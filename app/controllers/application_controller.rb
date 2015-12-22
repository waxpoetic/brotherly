class ApplicationController < ActionController::Base
  # Use the default app responder object.
  self.responder = Brotherly::Responder
  respond_to :html

  # Define a default HTML layout.
  layout :use_layout?
  class_attribute :html_layout
  self.html_layout ||= 'application'

  # Configure DecentExposure
  decent_configuration do
    strategy Brotherly::ExposureStrategy
  end

  expose :current_episode do
    Episode.current.decorate
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
