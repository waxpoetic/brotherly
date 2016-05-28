# Creates a new transcode job on AWS Elastic Transcoder.
module Transcode
  class Job
    include ActiveModel::Model

    EXTENSION = 'm3u8'.freeze
    AUDIO_PRESET = '1351620000001-200071'.freeze
    VIDEO_PRESETS = {
      '400k' => '1351620000001-200050',
      '600k' => '1351620000001-200040',
      '1000k' => '1351620000001-200030',
      '1500k' => '1351620000001-200020',
      '2000k' => '1351620000001-200010'
    }.freeze
    FORMAT = 'HLSv3'.freeze
    PREFIX = 'videos/'.freeze
    SEGMENT_DURATION = '2'.freeze

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
    def output_id
      @output ||= input.gsub(/flv|mp4/, EXTENSION)
    end

    # Parameters for each individual preset.
    #
    # @return [Array<Hash>] presets for transcoding
    def outputs
      VIDEO_PRESETS.map do |variant, preset_id|
        {
          key: "hls#{variant}/#{output_id}",
          preset_id: preset_id,
          segment_duration: SEGMENT_DURATION
        }
      end
    end

    # Parameters for the HLS playlist.
    #
    # @return [Hash] HLS playlist contents
    def playlist
      {
        name: output_id,
        format: FORMAT,
        output_keys: outputs.map { |output| output[:key] }
      }
    end

    # Parameters sent to the transcoder pipeline as a job.
    #
    # @return [Hash] job params
    def attributes
      {
        pipeline_id: Rails.application.secrets.aws_transcoder_pipeline_id,
        input: { key: input },
        output_key_prefix: PREFIX,
        outputs: outputs,
        playlists: [playlist]
      }
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

    # @return [Boolean] whether the job was created and a successful
    # request.
    def persisted?
      @persisted ||= false
    end

    # Start the transcode process after validating attributes.
    #
    # @return [Boolean] whether the transcode has begun.
    def save
      valid? && create && persisted?
    end

    private

    # @private
    def create
      @persisted = transcoder.create_job(attributes).success?
    end

    # @private
    # @return [Aws::ElasticTranscoder::Client]
    def transcoder
      @transcoder ||= Aws::ElasticTranscoder::Client.new(
        region: Rails.application.secrets.aws_region
      )
    end
  end
end
