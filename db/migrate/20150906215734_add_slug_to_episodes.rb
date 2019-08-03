# frozen_string_literal: true

class AddSlugToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :slug, :string
  end
end
