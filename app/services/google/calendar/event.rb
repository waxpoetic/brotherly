module Google
  class Calendar
    class Event
      attr_reader :id
      attr_reader :summary
      attr_reader :description
      attr_reader :location
      attr_reader :starts_at
      attr_reader :ends_at

      def initialize(params = {})
        @attributes = params.deep_symbolize_keys
        params.each do |param, value|
          instance_variable_set "@#{param}", value
        end
        @starts_at = parse_date @start
        @ends_at = parse_date @end
      end
    end
  end
end
