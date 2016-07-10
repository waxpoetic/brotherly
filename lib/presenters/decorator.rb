module Presenters
  class Presenter < Delegator
    attr_reader :model

    def initialize(model, **context)
      @model = model
      context.each do |option, value|
        instance_variable_set "@#{option}", value
      end
    end

    def self.delegate(*methods, to: :model, **options)
      super *methods, to: to, **options
    end

    def self.delegate_all
      # no-op, we already do this
    end

    def __getobj__
      @model
    end

    def helpers
      @helpers ||= Helpers.new
    end
    alias_method :h, :helpers
  end
end
