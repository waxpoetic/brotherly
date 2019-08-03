# frozen_string_literal: true

class AddSlugToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :slug, :string
  end
end
