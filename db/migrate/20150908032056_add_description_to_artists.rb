# frozen_string_literal: true

class AddDescriptionToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :description, :text
  end
end
