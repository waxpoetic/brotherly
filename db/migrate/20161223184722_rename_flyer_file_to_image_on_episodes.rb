class RenameFlyerFileToImageOnEpisodes < ActiveRecord::Migration[5.0]
  def change
    rename_column :episodes, :flyer_file_id, :image_id
  end
end
