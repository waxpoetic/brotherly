# frozen_string_literal: true
class DropAttributesFromPerformances < ActiveRecord::Migration[5.0]
  def change
    remove_column :performances, :mixcloud_url, :string
    remove_column :performances, :youtube_id, :string
  end
end
