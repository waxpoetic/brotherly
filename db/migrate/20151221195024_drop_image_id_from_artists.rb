# frozen_string_literal: true

class DropImageIdFromArtists < ActiveRecord::Migration[5.0]
  def change
    remove_column :artists, :image_id
  end
end
