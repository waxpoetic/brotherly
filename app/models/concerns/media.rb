# frozen_string_literal: true
# Allows for uploading audio and video files to records in the database.
# Used mainly on +Episode+ and +Performance+, this module also
# automatically kicks off transcode jobs in AWS after video is uploaded.
module Media
  extend ActiveSupport::Concern

  AUDIO_EXTENSIONS = %w(mp3 wav).freeze
  VIDEO_EXTENSIONS = %w(m3u8 mp4 flv).freeze

  included do
    attachment :audio_file, extension: AUDIO_EXTENSIONS
    attachment :video_file, extension: VIDEO_EXTENSIONS

    after_save :transcode_video!, if: :needs_video_transcode?
  end

  def needs_video_transcode?
    video_file_id_changed? || !video_transcoded?
  end

  def video_transcoded?
    video_transcoded_at.present?
  end

  protected

  def transcode_video!
    TranscodeVideoJob.perform_later self
  end
end
