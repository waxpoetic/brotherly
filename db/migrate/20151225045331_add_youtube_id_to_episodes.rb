class AddYoutubeIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :youtube_id, :string
  end
end
