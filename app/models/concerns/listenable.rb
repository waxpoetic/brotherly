# Add event publishing features to AR models.
module Listenable
  extend ActiveSupport::Concern

  EVENTS = %w(created updated destroyed saved)

  included do
    include Wisper::Publisher

    EVENTS.each do |event|
      send "after_#{event}".to_sym do |model|
        broadcast "#{model_name.param_name}_#{event}", model
      end
    end
  end
end
