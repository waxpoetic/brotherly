class FacebookifyEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    facebook_event = Facebook::Event.find(event.facebook_id)
    return unless facebook_event.present?
    event.update(
      facebook_description: facebook_event.description,
      ticket_url: facebook_event.ticket_url,
      cover_photo_url: facebook_event.cover_photo.url,
    )
  end
end
