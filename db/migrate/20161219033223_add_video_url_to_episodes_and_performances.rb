# frozen_string_literal: true
class AddVideoUrlToEpisodesAndPerformances < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :video_url, :string
    add_column :performances, :video_url, :string
  end
end
