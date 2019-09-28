# frozen_string_literal: true

class CreatePerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :performances do |t|
      t.references :artist,   index: true, foreign_key: true
      t.references :episode,  index: true, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :youtube_url
      t.string :mixcloud_url

      t.timestamps null: false
    end
  end
end
