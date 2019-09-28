# frozen_string_literal: true

class AddYoutubeIdToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :youtube_id, :string
  end
end
