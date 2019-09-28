# frozen_string_literal: true

class AddImageFileToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :image_file_id, :string
  end
end
