class SubscribersController < ApplicationController
  resource :subscriber

  def new
    render :new
  end

  def create
    subscriber.attributes = edit_params
    subscriber.save
    session[:subscriber] = subscriber.id
    respond_with subscriber, change: '#dialog'
  end

  def show
    respond_with subscriber
  end
end
