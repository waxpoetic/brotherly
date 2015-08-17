module Recordable
  extend ActiveSupport::Concern

  included do
    attachment :video_recording
    attachment :audio_recording
  end

  def recordings_changed?
    video_recording_changed? || audio_recording_changed?
  end
end
