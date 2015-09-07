# Controlled layout for admin functionality.
class Admin::BaseController < ApplicationController
  before_action :authenticate_user!

  # Override default HTML layout
  self.html_layout = 'admin'

  def self.resource(name, *attributes)
    model = name.to_s.classify.constantize
    collection = name.to_s.pluralize.to_sym

    expose name, except: [:index], attributes: :edit_params
    expose collection, only: [:index] do
      if params[:query]
        model.search params[:query]
      else
        model.all
      end
    end
  end

  def index
    render 'index'
  end

  def current_decorated_user
    Admin::UserDecorator.new current_user
  end
  helper_method :current_decorated_user
end
