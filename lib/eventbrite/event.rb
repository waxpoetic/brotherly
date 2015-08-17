require 'eventbrite-client'

module Eventbrite
  class Event
    attr_reader :attributes
    attr_reader :id

    def initialize(params = {})
      @attributes = params
    end

    def self.create(params = {})
      event = new(params)
      event.save
      event
    end

    def save
      client.event_post(attributes)
    end

    def create_ticket_class(params = {})
      client.event_ticket_classes_post(params)
    end

    def publish!
      client.event_publish_post(id)
    end

    private

    def client
      @client ||= EventbriteClient.new(
        app_key: Rails.application.secrets.eventbrite_api_key,
        user_key: Rails.application.secrets.eventbrite_user_token
      )
    end
  end
end
