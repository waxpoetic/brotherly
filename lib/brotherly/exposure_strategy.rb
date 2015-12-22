require 'decent_exposure/strong_parameters_strategy'
require 'draper/decoratable'

module Brotherly
  # A strategy for DecentExposure that automatically authorizes the
  # resource and decorates it with a presenter object.
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    delegate :current_page, :per_page, to: :controller

    # Generate a policy scope for all collection resources, then
    # decorate the finished object relation.
    def collection_resource
      collection_decorator.decorate(
        super.page(current_page).per(per_page),
        with: decorator
      )
    end

    def singular_resource
      decorator.decorate super
    end

    private

    def decorator
      model.decorator_class
    end

    def collection_decorator
      "#{model.model_name.plural.capitalize}Decorator".constantize
    end

    def model
      controller.model_name.to_s.classify.constantize
    end
  end
end
