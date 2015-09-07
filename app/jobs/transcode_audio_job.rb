class TranscodeAudioJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    AudioTranscoder.perform episode.audio_recording
  end
end
