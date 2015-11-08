class AdminController < ApplicationController
  self.responder = Brotherly::AdminResponder
  self.html_layout = 'admin'

  before_action :authenticate_user!

  helper_method :page_title
  helper_method :current_title
  helper_method :params_to_permit
  helper_method :model_name
  helper_method :show_path
  helper_method :new_path
  helper_method :edit_path

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
    render 'form'
  end

  def edit
    render 'form'
  end

  def show
    respond_with model
  end

  def create
    model.save
    respond_with model, location: index_path
  end

  def update
    model.update edit_params
    respond_with model, location: index_path
  end

  def destroy
    model.destroy
    respond_with model, location: index_path
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

  def edit_path *args
    public_send "edit_admin_#{model_name}_path", *args
  end

  def new_path
    public_send "new_admin_#{model_name}_path"
  end

  def index_path
    public_send "admin_#{collection_name}_path"
  end

  private

  def populate_headers
    request.env['X-Title'] = current_title
    request.env['X-Page-Title'] = page_title
    flash.each do |type, message|
      request.env["X-Flash-#{type.titleize}"] = message
    end
  end

  def current_resource
    if action_name == 'index'
      collection
    else
      model
    end
  end
end
