class AddVideoFileToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :video_file_id, :string
  end
end
