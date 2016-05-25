# Allows for uploading audio and video files to records in the database.
# Used mainly on +Episode+ and +Performance+, this module also
# automatically kicks off transcode jobs in AWS after video is uploaded.
module Media
  extend ActiveSupport::Concern

  AUDIO_EXTENSIONS = %w(mp3 wav)
  VIDEO_EXTENSIONS = %w(m3u8 mp4 flv)

  included do
    attachment :audio_file, extension: AUDIO_EXTENSIONS
    attachment :video_file, extension: VIDEO_EXTENSIONS

    after_save :transcode_audio!, if: :needs_audio_transcode?
    after_save :transcode_video!, if: :needs_video_transcode?
  end

  def needs_audio_transcode?
    audio_file_id_changed? || !audio_transcoded?
  end

  def needs_video_transcode?
    video_file_id_changed? || !video_transcoded?
  end

  def audio_transcoded?
    audio_transcoded_at.present?
  end

  def video_transcoded?
    video_transcoded_at.present?
  end

  protected

  def transcode_audio!
    if audio_file_url =~ /\.mp3\Z/
      episode.update transcoded_audio_at: Time.zone.now
    else
      TranscodeAudioJob.perform_later self
    end
  end

  def transcode_video!
    if video_file_url =~ /\.m3u8\Z/
      episode.update transcoded_video_at: Time.zone.now
    else
      TranscodeVideoJob.perform_later self
    end
  end
end
