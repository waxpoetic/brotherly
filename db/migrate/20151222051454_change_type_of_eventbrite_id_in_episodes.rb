class ChangeTypeOfEventbriteIdInEpisodes < ActiveRecord::Migration
  def change
    change_column :episodes, :eventbrite_event_id, :string
  end
end