class RenameMixcloudUrlToCloudcastKeyOnEpisodesAndPerformances < ActiveRecord::Migration
  def change
    %i(episodes performances).each do |table|
      rename_column table, :mixcloud_url, :cloudcast_key
    end
  end
end
