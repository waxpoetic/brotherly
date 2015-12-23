module Eventbrite
  class Event
    # Thrown when an event cannot be found on Eventbrite.
    class NotFound < StandardError
      # @param [String] id
      def initialize(id)
        super "Event with ID '#{id}' could not be found on Eventbrite"
      end
    end
  end
end
