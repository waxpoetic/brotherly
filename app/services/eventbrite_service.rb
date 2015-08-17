require 'service'

class EventbriteService < Service
  remote Eventbrite::Event
  local :episode

  def attributes
    episode.attributes.slice(
      :name, :starts_at, :ends_at
    )
  end

  delegate :url, to: :remote
end
