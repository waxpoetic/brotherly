# frozen_string_literal: true

class ChangeTypeOfEventbriteIdInEpisodes < ActiveRecord::Migration[5.0]
  def change
    change_column :episodes, :eventbrite_event_id, :string
  end
end
