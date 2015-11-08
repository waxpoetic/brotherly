require 'decent_exposure/strong_parameters_strategy'
require 'draper/decoratable'

module Brotherly
  # A strategy for DecentExposure that automatically authorizes the
  # resource and decorates it with a presenter object.
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    # Generate a policy scope for all collection resources, then
    # decorate the finished object relation.
    def collection_resource
      collection_decorator.decorate(
        super.tap do |c|
          controller.policy_scope c
        end.page(controller.current_page).per(controller.per_page),
      with: decorator)
    end

    def singular_resource
      decorator.decorate(
        super.tap do |m|
          controller.authorize m
        end
      )
    end

    private

    def decorator
      if admin?
        "Admin::#{model.decorator_class.name}".constantize
      else
        model.decorator_class
      end
    end

    def admin?
      controller.request.env['PATH_INFO'] =~ /admin/
    end

    def collection_decorator
      if admin?
        "Admin::#{model.model_name.plural.capitalize}Decorator".constantize
      else
        "#{model.model_name.plural.capitalize}Decorator".constantize
      end
    end

    def model
      controller.model_name.to_s.classify.constantize
    end
  end
end
