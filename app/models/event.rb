# frozen_string_literal: true

# Represents a single event in the google calendar. Reads from the
# +Event::Calendar+ service and collects the query in
# +Event::Collection+.
#
# TODO: This class should really be an amalgamation of a
# +Facebook::Event+ and a +Google::Calendar::Event+, but I haven't
# separated out the Google Calendar logic from the straight-up event
# logic here.
class Event
  include ActiveModel::Model
  include ActiveModel::Conversion

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
      @all ||= Event::Collection.new
    end

    # All events on the calendar since 1 hour ago from the time that
    # this method was called.
    #
    # @return [Event::Collection]
    def recent
      since 1.year.ago
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
  # @return [Boolean] whether +starts_at+ is not a +DateTime+ object.
  def all_day?
    !starts_at.is_a? DateTime
  end

  # Timestamp string for the front-end.
  #
  # @return [String]
  def time
    return "#{starts_at} all day" if all_day?
    "from #{starts_at.to_s(:short)} to #{ends_at.to_s(:short)}"
  end

  # brother.ly admins place the Facebook URL in the description of the
  # calendar event.
  #
  # @return [String]
  def facebook_url
    description
  end

  # Parse out the Facebook Event ID from the URL.
  #
  # @return [String]
  def facebook_event_id
    if facebook_url =~ %r{https://www.facebook.com/events/(\d+)}
      $1
    end
  end

  # Generated slug for direct event URLs.
  #
  # @return [String]
  def to_param
    [title.parameterize, starts_at.to_date].join('-')
  end

  # Facebook event description or hard-coded description from calendar
  # event.
  #
  # @return [String]
  def summary
    facebook_event&.description || description || 'No description available'
  end

  # Cover image URL for the Facebook event that will be shown on the
  # "More Info" page. This defaults to a placeholder image from
  # +placehold.it+ but we should probably be doing something better.
  #
  # @return [String] URL to the cover photo image
  def cover_image
    facebook_event&.cover_photo || placeholder_image
  end

  private

  # @private
  # @return [String] Placeholder image URL from +placehold.it+
  def placeholder_image
    "http://placehold.it/#{WIDTH}X#{HEIGHT}?text=#{placeholder_text}"
  end

  # @private
  # @return [String] Title for the placeholder image
  def placeholder_text
    title.gsub(/\s/, '+')
  end

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

  # Retrieves information from the Facebook Graph API about this event
  # if a URL is given as the description in the Google Calendar entry.
  #
  # @private
  # @return [Facebook::Event] Graph API model for this Facebook event
  def facebook_event
    return unless facebook_event_id.present?
    Facebook::Event.find facebook_event_id
  end
end
