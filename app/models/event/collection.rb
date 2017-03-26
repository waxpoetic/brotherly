class Event
  # Front-end for the +Event::Calendar+, allowing query manipulation and
  # record retrieval without having to write for the Google API
  # interface.
  #
  # @see Event
  # @see Event::Calendar
  class Collection
    include Enumerable

    attr_reader :calendar

    delegate :query, to: :@calendar

    def initialize
      @calendar = Google::Calendar.new
      @urls = @calendar.events.map(&:description).compact
      @facebook = Facebook::Event.where url: @urls
    end

    # Iterate over +Event+ records and attempt to find Facebook data
    # for them.
    #
    # @return [Iterator]
    def each
      @calendar.events.each do |event|
        yield Event.from(event, @facebook.find(event.description))
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


    # Find an event by its ID.
    #
    # @param id [String] ID of the given event.
    # @return [Event] when an upcoming event is found.
    # @raise [Event::NotFoundError] when event cannot be found
    def find(id)
      event = super { |google_event| google_event.id == id }
      raise NotFoundError, id if event.blank?
      Event.from(event)
    end

    # Outputs the query used by the calendar, for debugging purposes.
    #
    # @return [Hash] Query for searching calendar items.
    def to_query
      @calendar.query
    end

    # Returns a default +ActiveModel+ object that is used to determine
    # partial path for rendering the collection.
    #
    # @return [Event]
    def to_model
      Event.new
    end

    # Returns the entire collection as an +Array+ for usage in rendering
    # as a collection.
    #
    # @return [Array<Event>]
    def to_ary
      to_a
    end

    # Cache key for the collection includes the most recent
    # +:updated_at+ and busts the cache whenever that number changes
    # (e.g., a new calendar event is added or an existing one is
    # updated)
    #
    # @return [String] "events/$MAX_UPDATED_AT"
    def cache_key
      ['events', max(&:updated_at)].join('/')
    end
  end
end
