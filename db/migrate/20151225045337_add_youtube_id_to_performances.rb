class AddYoutubeIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :youtube_id, :string
  end
end
