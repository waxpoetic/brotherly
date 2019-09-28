# frozen_string_literal: true

class AddAudioRecordingIdToPerformances < ActiveRecord::Migration[5.0]
  def change
    add_column :performances, :audio_recording_id, :string
  end
end
