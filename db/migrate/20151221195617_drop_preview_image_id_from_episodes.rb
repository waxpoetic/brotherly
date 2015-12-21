class DropPreviewImageIdFromEpisodes < ActiveRecord::Migration
  def change
    remove_column :episodes, :preview_image_id
  end
end
