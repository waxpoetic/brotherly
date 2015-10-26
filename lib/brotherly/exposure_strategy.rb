require 'decent_exposure/strong_parameters_strategy'
require 'draper/decoratable'

module Brotherly
  # A strategy for DecentExposure that automatically authorizes the
  # resource and decorates it with a presenter object.
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    delegate :authorize, :policy_scope, :current_page, :per_page, :params, to: :controller

    # Generate a policy scope for all collection resources, then
    # decorate the finished object relation.
    def collection_resource
      collection_decorator.decorate_collection(
        super.tap do |c|
          policy_scope c
        end.page(current_page).per(per_page)
      )
    end

    def singular_resource
      decorator.decorate(
        super.tap do |r|
          authorize r
        end
      )
    end

    private

    def decorator
      return model.decorator_class unless controller.env['REQUEST_PATH'] =~ /admin/
      "Admin::#{model.decorator_class.name}".constantize
    end

    def collection_decorator
      if controller.env['REQUEST_PATH'] =~ /admin/
        "Admin::#{model.model_name.plural.capitalize}Decorator".constantize
      else
        "#{model.model_name.plural.classify}Decorator".constantize
      end
    end

    def model
      controller.model_name.to_s.classify.constantize
    end
  end
end
