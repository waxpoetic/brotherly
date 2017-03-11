# frozen_string_literal: true

# Represents a single event in the google calendar.
class Event
  include ActiveModel::Model

  REDIRECT_URL = 'urn:ietf:wg:oauth:2.0:oob'

  attr_accessor :id
  attr_accessor :title
  attr_accessor :description
  attr_accessor :location
  attr_accessor :starts_at
  attr_accessor :ends_at
  attr_accessor :all_day

  attr_reader :attributes

  delegate :to_json, :[], :include?, to: :attributes

  def initialize(params = {})
    @attributes = params.with_indifferent_access
    super @attributes
  end

  # The entire calendar.
  def self.calendar
    @calendar ||= Google::Calendar.new(
      client_id: Brotherly.secrets.google_calendar_client_id,
      client_secret: Brotherly.secrets.google_calendar_client_secret,
      calendar: Brotherly.secrets.google_calendar_id,
      redirect_url: REDIRECT_URL
    )
  end

  def self.all
    @all ||= Collection.new calendar.events
  end

  def all_day?
    !!all_day
  end

  def persisted?
    id.present?
  end

  def time
    return "#{starts_at} all day" if all_day?
    "from #{starts_at} to #{ends_at}"
  end
end
