module Eventbrite
  class Gateway
    attr_reader :app_key, :user_key

    def initialize
      @app_key = Rails.application.secrets.eventbrite_app_key,
      @user_key = Rails.application.secrets.eventbrite_user_key
    end

    def create_event(event)
      id = post_event(event.attributes).id
      return Response.new(success: false) unless id.present?
      # tickets = client.event_ticket_classes_post
      event = publish_event(id)
      Response.new id: id, event: event
    end

    private

    def post_event(attributes)
      client.event_post(event.attributes)
    end

    def publish_event(id)
      client.event_publish_post(id)
    end

    def client
      @client ||= EventbriteClient.new(
        app_key: app_key,
        user_key: user_key
      )
    end
  end
end
