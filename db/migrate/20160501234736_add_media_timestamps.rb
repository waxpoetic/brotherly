# frozen_string_literal: true
class AddMediaTimestamps < ActiveRecord::Migration
  def change
    %i(episodes performances).each do |table|
      add_column table, :audio_transcoded_at, :datetime
      add_column table, :video_transcoded_at, :datetime
    end
  end
end
