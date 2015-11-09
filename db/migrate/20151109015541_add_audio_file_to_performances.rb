class AddAudioFileToPerformances < ActiveRecord::Migration
  def change
    remove_column :performances, :audio_recording_id
    remove_column :performances, :video_recording_id
    add_column :performances, :audio_file_id, :string
  end
end
