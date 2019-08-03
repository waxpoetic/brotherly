# frozen_string_literal: true

class Event
  class NotFoundError < StandardError
    def initialize(id)
      super "Event not found for ID=#{id}"
    end
  end
end
