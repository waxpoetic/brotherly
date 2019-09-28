# frozen_string_literal: true

class AddShortLinkUrlToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :short_link_url, :string
  end
end
