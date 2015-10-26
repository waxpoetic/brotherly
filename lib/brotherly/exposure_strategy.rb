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
      super.tap do |c|
        policy_scope c
      end.page(current_page).per(per_page).decorate
    end

    def singular_resource
      super.tap do |r|
        authorize r
      end.decorate
    end

    # Attempt to authorize a given resource using its Pundit policy,
    # then inject +Draper::Decoratable+ so that 
    # def resource
    #   super.tap do |r|
    #     authorize r
    #   end.decorate
    # end
    #
    private
  end
end
