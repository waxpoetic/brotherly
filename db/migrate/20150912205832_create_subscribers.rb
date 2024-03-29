# frozen_string_literal: true

class CreateSubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
