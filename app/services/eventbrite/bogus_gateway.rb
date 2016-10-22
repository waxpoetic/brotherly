# frozen_string_literal: true
module Eventbrite
  class BogusGateway < Gateway
    def create_event(event)
      Response.new id: SecureRandom.random_number(5), event: event
    end
  end
end
