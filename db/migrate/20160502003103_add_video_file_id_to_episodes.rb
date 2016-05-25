class AddVideoFileIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :video_file_id, :string
  end
end
