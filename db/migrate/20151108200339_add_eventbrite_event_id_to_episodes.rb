class AddEventbriteEventIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :eventbrite_event_id, :integer
  end
end