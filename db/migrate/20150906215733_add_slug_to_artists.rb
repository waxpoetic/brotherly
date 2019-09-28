# frozen_string_literal: true

class AddSlugToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :slug, :string
  end
end
