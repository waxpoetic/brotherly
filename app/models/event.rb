# frozen_string_literal: true


# A single event on the brother.ly events calendar. Amalgamates data
# from +Google::Calendar::Event+ and +Facebook::Event using the
# +Event::Collection+ object.
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
  attr_accessor :facebook_event_id
  attr_accessor :facebook_event_url

  attr_reader :attributes

  delegate :to_json, :[], :include?, to: :attributes

  # Collection of +Event+ records from the +Event::Calendar+.
  #
  # @return [Event::Collection]
  def self.all
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
  def self.recent
    since 1.year.ago
  end

  # Forward all unknown methods to the collection.
  #
  # @param method [Symbol]
  # @param arguments [Array]
  def self.method_missing(method, *arguments)
    return super unless respond_to? method
    all.public_send method, *arguments
  end

  # Respond to methods defined on the collection at the class level.
  #
  # @param method [Symbol]
  # @param include_private [Boolean] Default: false
  def self.respond_to_missing?(method, include_private = false)
    all.respond_to?(method) || super
  end

  # Test if event has been saved. Required for +ActiveModel+
  # implementation.
  #
  # @return [Boolean]
  def persisted?
    id.present?
  end

  # Generated slug for direct event URLs.
  #
  # @return [String]
  def to_param
    [title.parameterize, starts_at.to_date].join('-')
  end
end
