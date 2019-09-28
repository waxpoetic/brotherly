# frozen_string_literal: true

class AddVideoFileIdToPerformances < ActiveRecord::Migration[5.0]
  def change
    add_column :performances, :video_file_id, :string
  end
end
