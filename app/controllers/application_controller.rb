class ApplicationController < ActionController::Base
  include ControllerResources
  include Halt

  responders :flash, :http_cache
  respond_to :html

  protect_from_forgery with: :exception

  halt ActiveRecord::RecordNotFound, with: :not_found

  after_action :populate_headers

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

  private

  def populate_headers
    response.headers['X-Flash'] = flash.to_json
    response.headers['X-Title'] = page_title
  end
end
