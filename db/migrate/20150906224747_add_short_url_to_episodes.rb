class AddShortUrlToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :short_url, :string
  end
end
