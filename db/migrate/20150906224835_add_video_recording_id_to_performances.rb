class AddVideoRecordingIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :video_recording_id, :string
  end
end
