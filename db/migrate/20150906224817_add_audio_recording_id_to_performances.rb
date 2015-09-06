class AddAudioRecordingIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :audio_recording_id, :string
  end
end
