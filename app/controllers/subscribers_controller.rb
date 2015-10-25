class SubscribersController < ApplicationController
  resource :subscriber do
    permit :name, :email
  end

  def new
    render :new
  end

  def create
    subscriber.save
    respond_with subscriber
  end

  def show
    respond_with subscriber
  end
end
