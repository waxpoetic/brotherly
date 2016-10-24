# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ControllerResources
  include Makeover::Presentable
  include Halt

  # Respond with HTML in a standardized way
  responders :flash, :http_cache
  respond_to :html

  # Don't render the layout when serving an Ajax request.
  layout :use_layout?
  DEFAULT_LAYOUT = 'application'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Handle 404s in a standardized way.
  halt ActiveRecord::RecordNotFound, with: :not_found

  # Require username & password to view staging server.
  http_basic_authenticate_with(
    username: Brotherly.secrets.http_basic_username,
    password: Brotherly.secrets.http_basic_password
  ) if Brotherly.basic_auth?

  protected

  def use_layout?
    request.xhr? ? false : DEFAULT_LAYOUT
  end

  def current_decorated_user
    present current_user
  end

  def model
    present super
  end

  def collection
    present super
  end

  private

  def present(model, *_args)
    super
  rescue NameError
    model
  end
end
