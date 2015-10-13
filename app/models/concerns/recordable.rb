module Recordable
  extend ActiveSupport::Concern

  included do
    attachment :video_recording, content_type: 'video/x-flv'
    attachment :audio_recording, content_type: 'audio/mp3'

    after_create :transcode_audio, if: :audio_recording_changed?
    after_create :transcode_video, if: :video_recording_changed?
  end

  def transcode_audio
    TranscodeAudioJob.perform_later self
  end

  def transcode_video
    TranscodeVideoJob.perform_later self
  end

  def downloadable?
    audio_recording.present? || video_recording.present?
  end
end
