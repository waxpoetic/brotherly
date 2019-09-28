# frozen_string_literal: true

class AddLinksToArtists < ActiveRecord::Migration[5.0]
  def change
    enable_extension :hstore
    add_column :artists, :links, :hstore
  end
end
