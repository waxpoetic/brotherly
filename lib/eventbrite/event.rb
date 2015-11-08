require 'eventbrite-client'

module Eventbrite
  class Event
    attr_reader :id
    attr_reader :attributes
    attr_reader :eventbrite_event

    delegate :url, to: :eventbrite_event

    def initialize(params = {})
      @id = params.delete :id
      @eventbrite_event = client.event_get(id)
      @attributes = @eventbrite_event.try(:attributes) || params
    end

    def self.create(params = {})
      event = new(params)
      event.save
      event
    end

    def save
      @id = client.event_post(attributes).id
    end

    def create_ticket_class(params = {})
      client.event_ticket_classes_post(params)
    end

    def publish!
      @eventbrite_event = client.event_publish_post(id)
    end

    def persisted?
      @id.present? && @eventbrite_event.present?
    end

    def to_h
      super.merge eventbrite_event_id: id
    end
  end
end
