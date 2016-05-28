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

    before_validation :clear_transcoded_at, if: :video_file_id_changed?

    after_save :transcode_video!, if: :needs_transcode?
  end

  def needs_transcode?
    video_transcoded_at.blank?
  end

  protected

  def transcode_video!
    TranscodeVideoJob.perform_later self
  end

  def clear_transcoded_at
    self.transcoded_at = nil
  end
end
