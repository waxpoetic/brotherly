# frozen_string_literal: true
class SubscribersController < ApplicationController
  resource :subscriber

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new permitted_params(Subscriber)
    session[:subscriber] = @subscriber.id
    respond_with @subscriber, change: '#dialog'
  end

  def show
    respond_with @subscriber
  end
end
