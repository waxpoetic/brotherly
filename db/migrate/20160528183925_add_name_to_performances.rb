class AddNameToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :name, :string, null: false
  end
end
