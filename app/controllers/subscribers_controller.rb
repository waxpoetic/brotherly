class SubscribersController < ApplicationController
  resource :subscriber

  def new
    @subscriber = Subscriber.new
    render :new
  end

  def create
    @subscriber = Subscriber.new params.permit(:name, :email)
    @subscriber.save
    session[:subscriber] = @subscriber.try(:id)
    respond_with @subscriber
  end

  def show
    respond_with @subscriber
  end
end
