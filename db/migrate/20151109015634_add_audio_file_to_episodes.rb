class AddAudioFileToEpisodes < ActiveRecord::Migration
  def change
    remove_column :episodes, :audio_recording_id
    remove_column :episodes, :video_recording_id
    add_column :episodes, :audio_file_id, :string
  end
end
