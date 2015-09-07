module Recordable
  extend ActiveSupport::Concern

  included do
    attachment :video_recording
    attachment :audio_recording

    after_create :transcode_audio, if: :audio_recording_changed?
    after_create :transcode_video, if: :video_recording_changed?
  end

  def transcode_audio
    TranscodeAudioJob.perform_later self
  end

  def transcode_video
    TranscodeVideoJob.perform_later self
  end
end
