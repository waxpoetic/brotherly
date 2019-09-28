# frozen_string_literal: true

class AddYoutubeIdToPerformances < ActiveRecord::Migration[5.0]
  def change
    add_column :performances, :youtube_id, :string
  end
end
