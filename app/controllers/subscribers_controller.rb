class SubscribersController < ApplicationController
  expose :subscriber

  def new
    render :new
  end

  def create
    subscriber.save && subscriber.subscribe
    respond_with subscriber
  end

  def show
    respond_with subscriber
  end
end
