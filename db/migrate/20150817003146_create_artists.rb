# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :image_id

      t.timestamps null: false
    end
  end
end
