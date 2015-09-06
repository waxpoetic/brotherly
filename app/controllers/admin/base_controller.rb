# Controlled layout for admin functionality.
class Admin::BaseController < ApplicationController
  layout :admin

  def self.resource(name, *attributes)
    model = name.to_s.classify.constantize
    collection = name.to_s.pluralize.to_sym

    expose name, except: [:index], attributes: :edit_params
    expose collection, only: [:index] do
      model.search params[:query]
    end
  end

  def index
    render 'index'
  end
end
