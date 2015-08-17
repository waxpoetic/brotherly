class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.string :eventbrite_url
      t.string :youtube_url
      t.string :mixcloud_url
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps null: false
    end
  end
end
