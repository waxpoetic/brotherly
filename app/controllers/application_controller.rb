# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ControllerResources
  include Makeover::Presentable

  # Respond with HTML in a standardized way
  responders :flash, :http_cache
  respond_to :html

  # Don't render the layout when serving an Ajax request.
  layout :use_layout?
  DEFAULT_LAYOUT = 'application'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :find_episode_resources

  # Handle 404s in a standardized way.
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # Render the 404 page and log the AR error message.
  #
  # @param exception [ActiveRecord::RecordNotFound]
  def not_found(exception)
    logger.error exception.message
    render :not_found, status: :not_found, error: exception
  end

  protected

  def per_page
    params[:limit] || 50
  end

  def current_page
    params[:page] || 1
  end

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

  def find_episode_resources
    @recent_episodes = present Episode.recent
    @current_episode = present Episode.current
    @search = present Search.new
  end

  def present(model, *_args)
    super
  rescue NameError
    model
  end
end
