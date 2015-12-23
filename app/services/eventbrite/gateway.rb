module Eventbrite
  class Gateway
    attr_reader :app_key, :user_key

    def initialize
      @app_key = Rails.application.secrets.eventbrite_app_key,
      @user_key = Rails.application.secrets.eventbrite_user_key
    end

    def create_event(event)
      id = client.event_post(event.attributes).id
      return Response.new(success: false) unless id.present?
      tickets = client.event_ticket_classes_post(params.merge(id: id))
      event = client.event_publish_post(id)
      Response.new id: id, event: event, tickets: tickets
    end

    private

    def client
      @client ||= EventbriteClient.new(
        app_key: app_key,
        user_key: user_key
      )
    end
  end
end
