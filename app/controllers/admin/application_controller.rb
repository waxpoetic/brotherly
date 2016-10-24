# frozen_string_literal: true
module Admin
  # Base controller for the admin panel, using the +Admin::Search+
  # refinement to +Administrate::Search+. This controller is also
  # responsible for authenticating admin users and setting default
  # options, such as the records shown per page, for all admin
  # controllers.
  class ApplicationController < Administrate::ApplicationController
    # helper TitleistHelper

    before_action :authenticate_user!

    # layout 'administrate/application'

    # protected

    # def records_per_page
    #   params[:per_page] || 36
    # end

    def find_resource(param)
      return super unless resource_class.respond_to? :friendly
      resource_class.friendly.find(param)
    end
  end
end
