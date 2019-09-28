# frozen_string_literal: true

class AddVideoFileIdToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :video_file_id, :string
  end
end
