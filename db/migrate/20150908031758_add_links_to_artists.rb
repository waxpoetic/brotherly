class AddLinksToArtists < ActiveRecord::Migration
  def change
    enable_extension :hstore
    add_column :artists, :links, :hstore
  end
end