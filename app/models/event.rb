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
  attr_accessor :owner
  attr_accessor :description
  attr_accessor :location
  attr_accessor :starts_at
  attr_accessor :ends_at
  attr_accessor :facebook_id

  attr_reader :attributes

  delegate :to_json, :[], :include?, to: :attributes

  class << self
    delegate :calendar, to: :all

    # Collection of +Event+ records from the +Event::Calendar+.
    #
    # @return [Event::Collection]
    def all
      @all ||= Event::Collection.new
    end

    # Collect origin objects together and merge their +to_event+
    # methods. All origins must respond to +to_event+.
    #
    # @param origins [Array<Object>]
    # @return [Event] New event object with amalgamated params.
    def self.from(*origins)
      new(
        origins.compact.each_with_object({}) do |params, origin|
          params.merge(origin.to_event)
        end
      )
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

  # Generated slug for direct event URLs.
  #
  # @return [String]
  def to_param
    [title.parameterize, starts_at.to_date].join('-')
  end
end
