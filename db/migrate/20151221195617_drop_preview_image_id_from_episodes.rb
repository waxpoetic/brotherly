# frozen_string_literal: true

class DropPreviewImageIdFromEpisodes < ActiveRecord::Migration[5.0]
  def change
    remove_column :episodes, :preview_image_id
  end
end
