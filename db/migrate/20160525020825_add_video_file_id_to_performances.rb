# frozen_string_literal: true
class AddVideoFileIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :video_file_id, :string
  end
end
