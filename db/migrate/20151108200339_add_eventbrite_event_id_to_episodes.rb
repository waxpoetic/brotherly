# frozen_string_literal: true

class AddEventbriteEventIdToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :eventbrite_event_id, :integer
  end
end
