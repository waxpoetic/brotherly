module Admin
  # Base controller for the admin panel, using the +Admin::Search+
  # refinement to +Administrate::Search+. This controller is also
  # responsible for authenticating admin users and setting default
  # options, such as the records shown per page, for all admin
  # controllers.
  class ApplicationController < Administrate::ApplicationController
    using Admin::Search

    before_action :authenticate_user!

    protected

    def records_per_page
      params[:per_page] || 36
    end
  end
end
