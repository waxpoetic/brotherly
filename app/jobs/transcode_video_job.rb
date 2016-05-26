class TranscodeVideoJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    return unless Transcode.create input: episode.video_file_url
    episode.update video_transcoded_at: Time.current
  end
end
