# Run transcoders on the episode.
class TranscodeEpisodeJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    transcoder.create_job(
      pipeline_id: secrets.aws_audio_pipeline_id,
      input: { key: episode.audio_file_url },
      output: { key: episode.audio_file_url.gsub(/wav/, 'm3u8') }
    )
  end

  private

  def transcoder
    @transcoder ||= AWS::ElasticTranscoder::Client.new(
      region: secrets.aws_region,
      credentials: {
        aws_access_key_id: secrets.aws_access_key_id,
        aws_secret_access_key: secrets.aws_secret_access_key
      }
    )
  end

  def secrets
    Rails.application.secrets
  end
end
