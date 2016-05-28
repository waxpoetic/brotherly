class CreateEventJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    Eventbrite::Event.create episode: episode
  end
end
