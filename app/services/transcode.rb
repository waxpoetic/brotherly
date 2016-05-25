# Creates a new transcode job on AWS Elastic Transcoder.
class Transcode
  include ActiveModel::Model

  PIPELINES = %i(audio video)
  EXTENSIONS = /mp3|mp4|flv|wav\Z/

  delegate :logger, to: Rails

  # @attribute! [rw]
  #   @return [Symbol] Pipeline to add transcode job to.
  attr_accessor :pipeline

  # @attribute! [rw]
  #   @return [String] File to be transcoded.
  attr_accessor :input

  validates :pipeline, presence: true, inclusion: { in: PIPELINES }
  validates :pipeline_id, presence: true
  validates :input, presence: true

  # Kick off a new transcode process.
  #
  # @param [Hash] params
  # @option [Symbol] :pipeline
  # @option [String] :input
  def self.create(params = {})
    new(params).tap(&:save)
  end

  # Read Rails secrets to determine AWS pipeline ID.
  #
  # @return [String] Configured AWS pipeline ID for given pipeline.
  def pipeline_id
    @pipeline_id ||= Rails.application.secrets["aws_#{pipeline}_pipeline_id"]
  end

  # Substitute input filename extension with the chosen extension for
  # this pipeline.
  #
  # @return [String] Input filename URL with extension subsituted.
  def output
    @output ||= input.gsub EXTENSIONS, extension
  end

  # Determine extension based on given pipeline.
  #
  # @return [String] Extension for the output filename.
  def extension
    case pipeline
    when :audio
      'mp3'
    when :video
      'm3u8'
    end
  end

  # Run validators and log errors if they exist.
  #
  # @return [Boolean] whether attributes are valid.
  def valid?
    super.tap do |result|
      unless result
        logger.debug "Transcode failed: #{errors.messages.to_a.to_sentence}"
      end
    end
  end

  # Start the transcode process after validating attributes.
  #
  # @return [Boolean] whether the transcode has begun.
  def save
    valid? && create
  end

  # Job params for elastic transcoder.
  #
  # @return [Hash]
  def params
    {
      pipeline_id: pipeline_id,
      input: { key: input },
      output: { key: output }
    }
  end

  private

  # @private
  # @return [Boolean] whether the transcode has begun.
  def create
    transcoder.create_job(params).success?
  end

  # @private
  # @return [Aws::ElasticTranscoder::Client]
  def transcoder
    @transcoder ||= Aws::ElasticTranscoder::Client.new(
      region: Rails.application.secrets.aws_region
    )
  end
end
