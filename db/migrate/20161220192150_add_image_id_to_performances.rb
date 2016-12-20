class AddImageIdToPerformances < ActiveRecord::Migration[5.0]
  def change
    add_column :performances, :image_id, :string
  end
end
