module Google
  class Calendar
    class Event
      attr_reader :attributes
      attr_reader :id
      attr_reader :summary
      attr_reader :description
      attr_reader :location
      attr_reader :starts_at
      attr_reader :ends_at
      attr_reader :updated_at

      def initialize(params = {})
        @attributes = params.deep_symbolize_keys
        params.each do |param, value|
          instance_variable_set "@#{param}", value
        end
        @starts_at = parse_date @start
        @ends_at = parse_date @end
        @updated_at = @updated
      end

      # Attributes for the top-level +Event+ model.
      #
      # @return [Hash]
      def to_event
        {
          id: id,
          name: summary,
          location: location,
          starts_at: starts_at,
          ends_at: ends_at,
          google_updated_at: updated_at
        }
      end

      private

      # Parse google time into either a +DateTime+ (for events with a
      # start/end time) or +Date+ (for all-day eventS) object.
      #
      # @private
      # @param google_time [Object] Time object from API
      # @return [Date|DateTime] depending on where we are reading
      # information from
      def parse_date(google_time)
        google_time.date_time || google_time.date
      end
    end
  end
end
