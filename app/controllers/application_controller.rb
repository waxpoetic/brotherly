class ApplicationController < ActionController::Base
  include ControllerResources
  include Halt

  responders :flash, :http_cache
  respond_to :html

  protect_from_forgery with: :exception

  halt ActiveRecord::RecordNotFound, with: :not_found

  protected

  def use_layout?
    'application' if request.xhr?
  end

  def current_decorated_user
    current_user.try :decorate
  end

  def model
    super.decorate
  end
end
