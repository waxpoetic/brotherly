require 'decent_exposure/strong_parameters_strategy'
require 'draper/decoratable'

module Brotherly
  # A strategy for DecentExposure that automatically authorizes the
  # resource and decorates it with a presenter object.
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    delegate :authorize, :policy_scope, to: :controller

    # Generate a policy scope for all collection resources, then
    # decorate the finished object relation.
    def collection_resource
      policy_scope super
    end

    # Attempt to authorize a given resource using its Pundit policy,
    # then inject +Draper::Decoratable+ so that 
    def resource
      super.tap do |r|
        authorize r
      end.decorate controller: controller
    rescue
      super.decorate controller: controller
    end
  end
end
