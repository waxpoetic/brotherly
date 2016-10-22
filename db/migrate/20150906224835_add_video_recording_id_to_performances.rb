# frozen_string_literal: true
class AddVideoRecordingIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :video_recording_id, :string
  end
end
