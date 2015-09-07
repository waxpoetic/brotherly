class TranscodeVideoJob < ActiveJob::Base
  queue_as :transcode_video

  def perform(episode)
    VideoTranscoder.perform episode.video_recording
  end
end
