require 'eventbrite-client'

module Eventbrite
  class Event
    attr_reader :id
    attr_reader :attributes
    attr_reader :eventbrite_event

    delegate :url, to: :eventbrite_event

    def initialize(params = {})
      @id = params.delete :id
      @attributes = event.try(:attributes) || params
    end

    def self.create(params = {})
      event = new(params)
      event.save
      event
    end

    def save
      valid? && create.success?
    end

    def persisted?
      id.present? && event.present?
    end

    def to_h
      super.merge eventbrite_event_id: id
    end

    private

    def create
      @response ||= begin
                      res = gateway.create_event(self)
                      @id = res.id if res.success?
                      res
                    end
    end

    def data
      @data ||= begin
                   gateway.event_get(id)
                 rescue
                   fail NotFound, id
                 end
    end

    def gateway
      @gateway ||= Gateway.new
    end
  end
end
