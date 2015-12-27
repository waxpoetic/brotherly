class DropYoutubeUrlFromPerformnacesAndEpisodes < ActiveRecord::Migration
  def change
    %i(episodes performances).each do |table|
      remove_column table, :youtube_url, :string
    end
  end
end
