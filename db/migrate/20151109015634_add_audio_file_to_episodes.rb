# frozen_string_literal: true

class AddAudioFileToEpisodes < ActiveRecord::Migration[5.0]
  def change
    remove_column :episodes, :audio_recording_id
    remove_column :episodes, :video_recording_id
    add_column :episodes, :audio_file_id, :string
  end
end
