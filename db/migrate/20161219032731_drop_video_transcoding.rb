# frozen_string_literal: true
class DropVideoTranscoding < ActiveRecord::Migration[5.0]
  def change
    remove_column :episodes, :transcoded
    remove_column :episodes, :video_file_id
    remove_column :episodes, :video_transcoded_at

    remove_column :performances, :video_file_id
    remove_column :performances, :video_transcoded_at

    remove_column :episodes, :short_url
  end
end
