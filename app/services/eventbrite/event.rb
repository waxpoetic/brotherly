require 'eventbrite-client'

module Eventbrite
  class Event
    include ActiveModel::Model

    attr_reader :id
    attr_reader :attributes
    attr_reader :eventbrite_event

    delegate :url, to: :eventbrite_event, allow_nil: true
    delegate :[], to: :data, allow_nil: true

    def initialize(params = {})
      @id = params[:id]
      @params = params
      @data = {}
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
      id.present? && data.any?
    end

    def to_h
      { eventbrite_event_id: id }
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
                 rescue Gibbon::Error
                   raise NotFound, id
                 end
    end

    def gateway
      @gateway ||= Gateway.new
    end
  end
end
