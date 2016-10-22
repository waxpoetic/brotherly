# frozen_string_literal: true
module Eventbrite
  class Response
    attr_reader :id, :event, :tickets

    def initialize(id: '', event: {}, tickets: {})
      @id = id
      @event = event
      @tickets = tickets
    end

    def success?
      id.present?
    end
  end
end
