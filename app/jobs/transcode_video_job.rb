class TranscodeVideoJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    return unless Transcode.create(
      pipeline: :video, input: episode.video_file_url
    )
    episode.update video_transcoded_at: Time.zone.now
  end
end
