require 'decent_exposure/strong_parameters_strategy'

module Brotherly
  # A strategy for DecentExposure that automatically authorizes the
  # resource and decorates it with a presenter object.
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    delegate :authorize, :policy_scope, to: :controller

    # Generate a policy scope for all collection resources, then
    # decorate the finished object relation.
    def collection_resource
      policy_scope(super).decorate_all
    end

    # Attempt to authorize a given resource using its Pundit policy,
    # then inject +Draper::Decoratable+ so that 
    def resource
      authorized_resource = super.tap do |resource_object|
        authorize resource_object

        unless resource_object.respond_to? :decorate
          resource_object.send :include, Draper::Decoratable
        end
      end

      authorized_resource.decorate
    end
  end
end
