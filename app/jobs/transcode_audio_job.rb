class TranscodeAudioJob < ActiveJob::Base
  queue_as :transcode_audio

  def perform(episode)
    AudioTranscoder.perform episode.audio_recording
  end
end
