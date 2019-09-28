# frozen_string_literal: true

class AddShortUrlToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :short_url, :string
  end
end
