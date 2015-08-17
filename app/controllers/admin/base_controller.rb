class Admin::BaseController < ApplicationController
  include Pundit

  layout :admin

  before_action :authenticate_and_authorize

  rescue_from Pundit::NotAuthorizedError, with: :redirect_to_login

  def index
    render 'index'
  end

  private

  def redirect_to_login
    redirect_to user_sign_in_path and return
  end

  def authenticate_and_authorize
    authenticate_user! && authorize_resource
  end

  def authorize_resource
    authorize current_user, current_resource, current_action
  end

  def current_action
    "#{action_name}?"
  end
end
