class AdminController < ApplicationController
  self.html_layout = 'admin'

  before_action :authenticate_user!

  helper_method :page_title
  helper_method :current_title

  # after_action :verify_policy_scoped
  # after_action :verify_authorized
  after_action :populate_headers

  expose :query do
    collection.object.ransack params[:q]
  end

  def dashboard
    render :dashboard
  end

  def index
    respond_with collection
  end

  def new
    render template: 'form'
  end

  def edit
    render template: 'form'
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
      "#{current_title} | #{Rails.application.config.name}"
    else
      Rails.application.config.name
    end
  end

  private

  def populate_headers
    request.env['X-Title'] = current_title
    request.env['X-Page-Title'] = page_title
    flash.each do |type, message|
      request.env["X-Flash-#{type.titleize}"] = message
    end
  end
end
