class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.string :eventbrite_url
      t.string :youtube_url
      t.string :mixcloud_url
      t.string :facebook_url
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :video_recording_id
      t.string :audio_recording_id

      t.timestamps null: false
    end
  end
end
