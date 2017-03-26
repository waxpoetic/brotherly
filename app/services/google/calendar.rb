module Google
  # Represents a single calendar object on Google's side. Also performs
  # all the calendar-specific API calls via the +Google::Client+
  class Calendar
    API_SCOPE = Apis::CalendarV3::AUTH_CALENDAR_READONLY
    DEFAULT_ORDER_BY = 'startTime'
    DEFAULT_MAX_RESULTS = 2500
    SERVICE = Apis::CalendarV3::CalendarService

    include Enumerable

    delegate :each, to: :events

    attr_reader :id
    attr_reader :client

    def initialize
      @id = Rails.configuration.google_calendar_id
      @client = Google::Client.new(API_SCOPE)
    end

    # Iterate over found events in the calendar.
    #
    # @return [Array]
    def events
      @events ||= response.items.map { |item| Calendar::Event.new(item) }
    end

    # The query used to search events in the Google Calendar API
    #
    # @return [Hash]
    def query
      @query ||= {
        single_events: true,
        order_by: DEFAULT_ORDER_BY,
        max_results: DEFAULT_MAX_RESULTS,
        time_min: Time.current.iso8601
      }
    end

    private

    # Raw HTTP response data from search query.
    #
    # @private
    # @return [Google::Api::Response]
    def response
      client.with SERVICE do |service|
        service.list_events(id, query)
      end
    end
  end
end
