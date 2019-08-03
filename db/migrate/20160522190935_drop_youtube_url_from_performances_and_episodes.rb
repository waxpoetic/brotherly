# frozen_string_literal: true

class DropYoutubeUrlFromPerformancesAndEpisodes < ActiveRecord::Migration
  def change
    remove_column :performances, :youtube_url, :string
    remove_column :episodes, :youtube_url, :string
  end
end
