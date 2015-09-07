class ApplicationController < ActionController::Base
  include Pundit

  # Use the default app responder object.
  self.responder = Brotherly::Responder
  respond_to :html

  # Define a default HTML layout.
  layout :use_layout?

  # Configure DecentExposure
  decent_configuration do
    strategy Brotherly::ExposureStrategy
  end

  expose :recent_episodes do
    Episode.latest.limit(5)
  end

  expose :upcoming_episodes do
    Episode.upcoming.limit(5)
  end

  expose :search do
    Search.new
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def unauthorized(exception)
    logger.error exception.message
    render :unauthorized, status: :unauthorized, error: exception
  end

  def not_found(exception)
    logger.error exception.message
    render :not_found, status: :not_found, error: exception
  end

  def use_layout?
    request.xhr? ? false : html_layout
  end

  def html_layout
    'application'
  end

  def current_decorated_user
    Admin::UserDecorator.new current_user
  end
end
