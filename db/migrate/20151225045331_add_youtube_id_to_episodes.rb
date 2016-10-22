# frozen_string_literal: true
class AddYoutubeIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :youtube_id, :string
  end
end
