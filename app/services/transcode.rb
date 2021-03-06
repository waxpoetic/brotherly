# frozen_string_literal: true

# Converts a given +Refile::Attachment+ to HLS with AWS Elastic Transcoder.
# This allows videos to be streamed on the web application without
# causing too much strain on the client. We convert videos to HLS via
# this class and then conventionally work out URLs on the frontend based
# on whether a transcode was recorded.
class Transcode
  # Preset IDs and variants for each video transcode output.
  VIDEO_PRESETS = {
    '400k' => '1351620000001-200050',
    '600k' => '1351620000001-200040',
    '1000k' => '1351620000001-200030',
    '1500k' => '1351620000001-200020',
    '2000k' => '1351620000001-200010'
  }.freeze

  # Video format we will be transcoding to.
  FORMAT = 'HLSv3'

  # How long HLS segments will be (in seconds).
  SEGMENT_DURATION = '2'

  # Folder prefix for transcoded files.
  PREFIX = 'episodes'

  attr_reader :id, :name, :output_prefix

  # Derive input name and output prefixes from refile video attachment.
  #
  # @param id [String] Identifier to video file which is being transcoded.
  # @param name [String] Name of the HLS playlist.
  def initialize(id)
    @id = id
    @name = id.parameterize.gsub(/\Araw-videos-|-mp4\Z/, '')
    raise ArgumentError, "Video cannot be blank" if @id.blank?
    raise ArgumentError, "Name cannot be blank" if @name.blank?

    @output_prefix = "#{PREFIX}/#{name}/"
  end

  def self.call(id)
    new(id).save
  end

  # Parameters for each individual preset.
  #
  # @return [Array<Hash>] presets for transcoding
  def outputs
    VIDEO_PRESETS.map do |variant, preset_id|
      {
        key: "#{name}-#{variant}",
        thumbnail_pattern: "#{name}-#{variant}-{count}",
        preset_id: preset_id,
        segment_duration: SEGMENT_DURATION
      }
    end
  end

  def output_keys
    outputs.map { |output| output[:key] }
  end

  # Parameters for the HLS playlist.
  #
  # @return [Hash] HLS playlist contents
  def playlist
    {
      name: name,
      format: FORMAT,
      output_keys: output_keys
    }
  end

  # Parameters sent to the transcoder pipeline as a job.
  #
  # @return [Hash] job params
  def attributes
    {
      pipeline_id: Rails.application.secrets.aws_transcoder_pipeline_id,
      input: { key: id },
      output_key_prefix: output_prefix,
      outputs: outputs,
      playlists: [playlist]
    }
  end

  # Create the job on AWS Elastic Transcoder.
  #
  # @private
  # @return [Boolean] whether the request was successful.
  def save
    transcoder.create_job(attributes).successful?
  end

  private

  # AWS Elastic Transcoder client instance.
  #
  # @private
  # @return [Aws::ElasticTranscoder::Client]
  def transcoder
    @transcoder ||= Aws::ElasticTranscoder::Client.new(
      region: Rails.application.secrets.aws_region
    )
  end
end
