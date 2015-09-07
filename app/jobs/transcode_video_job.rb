class TranscodeVideoJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    VideoTranscoder.perform episode.video_recording
  end
end
