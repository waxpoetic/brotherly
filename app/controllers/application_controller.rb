class ApplicationController < ActionController::Base
  # Use the default app responder object.
  self.responder = Application::Responder
  respond_to :html

  # Define a default HTML layout.
  layout :use_layout?
  class_attribute :html_layout
  self.html_layout ||= 'application'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(exception)
    logger.error exception.message
    render :not_found, status: :not_found, error: exception
  end

  def per_page
    params[:limit] || 50
  end

  def current_page
    params[:page] || 1
  end

  protected

  def use_layout?
    request.xhr? ? false : html_layout
  end

  def current_decorated_user
    current_user.try :decorate
  end
end
