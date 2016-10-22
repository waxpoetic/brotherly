# frozen_string_literal: true
class AddPreviewImageIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :preview_image_id, :string
  end
end
