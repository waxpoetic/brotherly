# Creates a new transcode job on AWS Elastic Transcoder.
class Transcode
  include ActiveModel::Model

  ORIGINAL_EXTENSIONS = /mp3|mp4|flv|wav\Z/
  EXTENSION = 'm3u8'
  AUDIO_PRESET = '1351620000001-200071'
  VIDEO_PRESETS = {
    '400k' => '1351620000001-200050',
    '600k' => '1351620000001-200040',
    '1000k' => '1351620000001-200030',
    '1500k' => '1351620000001-200020',
    '2000k' => '1351620000001-200010'
  }
  FORMAT = 'HLSv3'
  PREFIX = 'videos/'
  SEGMENT_DURATION = '2'

  delegate :logger, to: Rails

  # @attribute! [rw]
  #   @return [String] File to be transcoded.
  attr_accessor :input

  validates :input, presence: true

  # Kick off a new transcode process.
  #
  # @param [Hash] params
  # @option [Symbol] :pipeline
  # @option [String] :input
  def self.create(params = {})
    new(params).tap(&:save)
  end

  # Substitute input filename extension with the chosen extension for
  # this pipeline.
  #
  # @return [String] Input filename URL with extension subsituted.
  def output
    @output ||= Digest::SHA256.hexdigest input.encode('UTF-8')
  end

  # Run validators and log errors if they exist.
  #
  # @return [Boolean] whether attributes are valid.
  def valid?
    super.tap do |result|
      unless result
        Rails.logger.debug(
          "Transcode failed: #{errors.messages.to_a.to_sentence}"
        )
      end
    end
  end

  # Start the transcode process after validating attributes.
  #
  # @return [Boolean] whether the transcode has begun.
  def save
    valid? && create && persisted?
  end

  def persisted?
    @job.success?
  end

  def outputs
    PRESETS.map do |variant, preset_id|
      {
        key: "hls#{variant}/#{output}",
        preset_id: preset_id,
        segment_duration: SEGMENT_DURATION
      }
    end
  end

  def playlist
    {
      name: output_key,
      format: FORMAT,
      output_keys: outputs.map { |output| output[:key] }
    }
  end

  def attributes
    {
      pipeline_id: Rails.application.secrets.aws_transcoder_pipeline_id,
      input: { key: input },
      output_key_prefix: prefix,
      outputs: outputs,
      playlists: [playlist]
    }
  end

  private

  # @private
  def create
    @job = transcoder.create_job(attributes)
  end

  # @private
  # @return [Aws::ElasticTranscoder::Client]
  def transcoder
    @transcoder ||= Aws::ElasticTranscoder::Client.new(
      region: Rails.application.secrets.aws_region
    )
  end
end
