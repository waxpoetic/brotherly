class AddNameToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :name, :string
  end
end
