# frozen_string_literal: true

# Represents a single event in the google calendar. Reads from the
# +Event::Calendar+ service and collects the query in
# +Event::Collection+.
class Event
  include ActiveModel::Model

  attr_accessor :id
  attr_accessor :title
  attr_accessor :description
  attr_accessor :location
  attr_accessor :starts_at
  attr_accessor :ends_at

  attr_reader :attributes

  delegate :to_json, :[], :include?, to: :attributes

  def initialize(params = {})
    @attributes = params.with_indifferent_access
    @attributes[:starts_at] = parse_date(params[:starts_at])
    @attributes[:ends_at] = parse_date(params[:ends_at])
    super @attributes
  end

  class << self
    delegate :calendar, to: :all

    # Collection of +Event+ records from the +Event::Calendar+.
    #
    # @return [Event::Collection]
    def all
      @all ||= Collection.new
    end

    # All events on the calendar since 1 hour ago from the time that
    # this method was called.
    #
    # @return [Event::Collection]
    def recent
      since 1.hour.ago.to_datetime
    end

    # Populate +Event+ model object with data from an +Event::Calendar+
    # item.
    #
    # @param item [Event::Calendar::Item]
    # @return [Event]
    def from_calendar(item)
      new(
        id: item.id,
        title: item.summary,
        description: item.description,
        location: item.location,
        starts_at: item.start,
        ends_at: item.end
      )
    end

    # Forward all unknown methods to the collection.
    #
    # @param method [Symbol]
    # @param arguments [Array]
    def method_missing(method, *arguments)
      return super unless respond_to? method
      all.public_send method, *arguments
    end

    # Respond to methods defined on the collection at the class level.
    #
    # @param method [Symbol]
    # @param include_private [Boolean] Default: false
    def respond_to_missing?(method, include_private = false)
      all.respond_to?(method) || super
    end
  end

  # Test if event has been saved.
  #
  # @return [Boolean]
  def persisted?
    id.present?
  end

  # Test if this event is occurring all day.
  #
  # @return [Boolean] whether +starts_at+ is a +Date+ object.
  def all_day?
    starts_at.is_a? Date
  end

  # Timestamp string for the front-end.
  #
  # @return [String]
  def time
    return "#{starts_at.to_s(:long)} all day" if all_day?
    "from #{starts_at.to_s(:short)} to #{ends_at.to_s(:short)}"
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
    return Date.parse(google_time.date) unless google_time.date_time.present?
    DateTime.parse(google_time.date_time)
  end
end
