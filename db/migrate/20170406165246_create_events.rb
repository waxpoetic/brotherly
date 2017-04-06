class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
