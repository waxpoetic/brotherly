# frozen_string_literal: true

class AddVideoRecordingIdToPerformances < ActiveRecord::Migration[5.0]
  def change
    add_column :performances, :video_recording_id, :string
  end
end
