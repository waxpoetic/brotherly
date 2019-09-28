# frozen_string_literal: true

class AddPreviewImageIdToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :preview_image_id, :string
  end
end
