class DropImageIdFromArtists < ActiveRecord::Migration
  def change
    remove_column :artists, :image_id
  end
end