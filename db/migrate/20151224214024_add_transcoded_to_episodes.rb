class AddTranscodedToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :transcoded, :boolean, default: false, null: false
  end
end