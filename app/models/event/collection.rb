class Event
  # Front-end for the +Event::Calendar+, allowing query manipulation and
  # record retrieval without having to write for the Google API
  # interface.
  #
  # @see Event
  # @see Event::Calendar
  class Collection
    include Enumerable

    delegate :events, :query, to: :@calendar

    def initialize
      @calendar = Event::Calendar.new
    end

    # Iterate over +Event+ records.
    #
    # @return [Iterator]
    def each
      @calendar.each do |event|
        yield Event.from_calendar(event)
      end
    end

    # Search event records by given params.
    #
    # @param params [Hash] Parameters to match over events.
    # @return [Event::Collection] This object.
    def where(params = {})
      select do |event|
        params.any? do |param, value|
          event[param] == value
        end
      end
      self
    end

    # Order by a given attribute.
    #
    # @param attribute [Symbol|String] Attribute to order results by
    # @return [Event::Collection] This object.
    def order(attribute)
      @calendar.query[:order_by] = attribute.to_s.camelize :lower
      self
    end

    # Filter by event end time.
    #
    # @param time [Time] Minimum start time for results.
    # @return [Event::Collection] This object.
    def since(time)
      @calendar.query[:time_min] = time.iso8601
      self
    end

    # Limit number of results that are returned. Default is 2500 (max).
    #
    # @param number [Integer]
    # @return [Event::Collection] This object.
    def limit(number)
      @calendar.query[:max_results] = number
      self
    end

    # Outputs the query used by the calendar, for debugging purposes.
    #
    # @return [Hash] Query for searching calendar items.
    def to_query
      @calendar.query
    end

    # Find an event by its ID.
    #
    # @param id [String] ID of the given event.
    # @return [Event] when an upcoming event is found.
    # @raise [Event::NotFoundError] when event cannot be found
    def find(id)
      params = super { |event| event.id == id }
      raise NotFoundError, id if params.blank?
      Event.from_calendar(params)
    end
  end
end
