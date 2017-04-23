# frozen_string_literal: true

require_dependency 'facebook'

module Facebook
  # Represents a Facebook event from the Graph API. Events can be found
  # by passing their ID into +Facebook::Event.find+, which will return a
  # +Facebook::Event+ object back to you with methods representing the
  # various data points of an event. We also "massage" some data like
  # the +venue+ and +owner+ so they're easier to access.
  class Event
    include ActiveModel::Model

    PRIVACY_OPEN = 'OPEN'

    attr_accessor :id
    attr_accessor :name
    attr_accessor :description
    attr_accessor :location

    def initialize(params = {})
      params.each do |param, value|
        instance_variable_set "@#{param}", value
      end
    end

    def self.find(id)
      new Facebook.graph.get_object("/#{id}").deep_symbolize_keys
    rescue Koala::Facebook::ClientError => exception
      Rails.logger.error "Facebook event not found by ID=#{id}"
      Rails.logger.error exception.message
      nil
    end

    def all_day?
      @is_date_only
    end

    def private?
      @privacy != PRIVACY_OPEN
    end

    def venue
      @venue[:name]
    end

    def owner
      @owner[:name]
    end

    def starts_at
      @starts_at ||= Time.parse(@start_time)
    end

    def ends_at
      @ends_at ||= Time.parse(@end_time)
    end
  end
end
