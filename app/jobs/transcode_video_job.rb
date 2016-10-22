# frozen_string_literal: true
class TranscodeVideoJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    transcode = Transcode.new episode.video_file_id, episode.playlist_name
    episode.update video_transcoded_at: Time.current if transcode.save
  end
end
