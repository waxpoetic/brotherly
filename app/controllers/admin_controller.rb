# Controlled layout for admin functionality.
class AdminController < ApplicationController
  before_action :authenticate_user!

  helper_method :page_title
  helper_method :current_title

  after_action :verify_policy_scoped
  after_action :verify_authorized
  after_action :populate_headers

  def dashboard
    render :dashboard
  end

  def index
    respond_with collection
  end

  def new
    render :form
  end

  def edit
    render :form
  end

  def show
    respond_with model
  end

  def create
    model.save
    respond_with model
  end

  def update
    model.update edit_params
    respond_with model
  end

  def destroy
    model.destroy
    respond_with model
  end

  protected

  def current_title
    t '.title'
  rescue
    nil
  end

  def page_title
    if current_title.present?
      "#{current_title} | #{Rails.application.config.title}"
    else
      Rails.application.config.title
    end
  end

  private

  def populate_headers
    request.env['X-Title'] = page_title
    request.env['X-Page-Title'] = title_text
    flash.each do |type, message|
      request.env["X-Flash-#{type.titleize}"] = message
    end
  end
end
