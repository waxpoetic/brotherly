# Add event publishing features to AR models.
module Listenable
  extend ActiveSupport::Concern

  EVENTS = {
    'create' => 'created',
    'save' => 'saved',
    'destroy' => 'destroyed',
    'update' => 'updated'
  }

  included do
    include Wisper::Publisher

    EVENTS.each do |callback, event|
      send "after_#{callback}".to_sym do |model|
        broadcast "#{model_name.param_name}_#{event}", model
      end
    end
  end
end
