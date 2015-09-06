require 'service'
require 'eventbrite'

class EventbriteService < Brotherly::Service
  remote Eventbrite::Event
  local :episode

  VENUE_ID = 0
  FORMAT_ID = 0
  CATEGORY_ID = 0
  SUBCATEGORY_ID = 0

  after_create :create_ticket_class, :publish_event

  def attributes
    episode.attributes.slice(
      :name, :description
    ).merge(
      listed: true,
      capacity: Rails.application.config.capacity,
      currency: 'USD',
      venue_id: VENUE_ID,
      format_id: FORMAT_ID,
      category_id: CATEGORY_ID,
      subcategory_id: SUBCATEGORY_ID,
      start: {
        utc: episode.decorate.starts_at,
        timezone: Time.zone
      },
      end: {
        utc: episode.decorate.ends_at,
        timezone: Time.zone
      }
    )
  end

  delegate :url, to: :remote

  private

  def publish_event
    remote.publish!
  end

  def create_ticket_class
    remote.create_ticket_class(
      name: 'General Admission',
      description: 'It gets you drunk',
      cost: 'USD1000',
      sales_start: Time.zone.now.to_s(:rfc822),
      sales_end: (starts_at - 6.hours).to_s(:rfc822),
      include_fee: true
    )
  end
end
