class Event
  class Collection
    include Enumerable

    def initialize(events = [])
      @events = events.map do |event|
        {
          id: event.id,
          title: event.title,
          description: event.description,
          location: event.location,
          starts_at: event.start_time,
          ends_at: event.end_time,
          all_day: event.all_day,
          properties: event.extended_properties
        }
      end
    end

    def each
      @events.each { |event| yield Event.new(event) }
    end

    def where(params = {})
      @events.select! do |event|
        params.any? do |param, value|
          event[param] == value
        end
      end
    end

    def find(id)
      params = @events.find { |event| event[:id] == id }
      raise "Not found: #{id}" if params.blank?
      new(params)
    end
  end
end
