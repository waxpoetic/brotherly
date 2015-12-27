module Brotherly
  class Listener
    class_attribute :events

    attr_reader :model

    def initialize(model)
      @model = model
    end

    def self.inherited(listener)
      Wisper.subscribe listener, async: true
    end

    def self.on(*events)
      self.events = events

      events.each do |event_name|
        self.class.define_method "#{model_name}_#{event_name}" do |model|
          new(model).perform
        end
      end
    end

    def perform
      raise NotImplementedError
    end
  end
end
