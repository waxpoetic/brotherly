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

  before_action :cache_page, if: -> { request.get? }

  protected

  def use_layout?
    request.xhr? ? false : DEFAULT_LAYOUT
  end

  def current_decorated_user
    present current_user
  end

  def model
    if model_class.public_methods.include? :friendly
      present model_class.friendly.find(params[:id])
    else
      present model_class.find(params[:id])
    end
  end

  def collection
    present super
  end

  private

  def present(model, *_args)
    super
  rescue NameError => exception
    Rails.logger.error "#present --> #{exception}"
    model
  end

  def cache_page
    expires_in 24.hours, public: true
  end
end
