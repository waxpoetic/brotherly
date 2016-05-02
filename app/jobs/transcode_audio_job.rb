class TranscodeAudioJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    return unless Transcode.create(
      pipeline: :audio, input: episode.audio_file_url
    )
    episode.update audio_transcoded_at: Time.zone.now
  end
end
