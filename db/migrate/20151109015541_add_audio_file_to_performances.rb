# frozen_string_literal: true

class AddAudioFileToPerformances < ActiveRecord::Migration[5.0]
  def change
    remove_column :performances, :audio_recording_id
    remove_column :performances, :video_recording_id
    add_column :performances, :audio_file_id, :string
    add_column :performances, :video_file_id, :string
  end
end
