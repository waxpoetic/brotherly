# frozen_string_literal: true
class TranscodeVideoJob < ActiveJob::Base
  queue_as :default

  def perform(media)
    transcode = Transcode.new media.video_file_id, media.playlist_name
    media.update video_transcoded_at: Time.current if transcode.save
  end
end
