class TranscodeAudioJob < ActiveJob::Base
  queue_as :transcode_audio

  def perform(episode)
    TranscodeAudioWorker.perform episode.audio_recording
  end
end
