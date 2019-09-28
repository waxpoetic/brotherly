# frozen_string_literal: true

class AddFlyerFileToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :flyer_file_id, :string
  end
end
