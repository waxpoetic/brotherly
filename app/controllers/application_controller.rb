class ApplicationController < ActionController::Base
  include Pundit

  # Use the default app responder object.
  self.responder = Brotherly::Responder
  respond_to :html

  # Configure DecentExposure
  decent_configuration do
    strategy Brotherly::ExposureStrategy
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
end
