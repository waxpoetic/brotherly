class TranscodeVideoJob < ActiveJob::Base
  queue_as :transcode_video

  def perform(episode)
    TranscodeVideoWorker.perform episode.video_recording
  end
end
