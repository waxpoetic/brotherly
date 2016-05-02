class AddShortLinkUrlToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :short_link_url, :string
  end
end
