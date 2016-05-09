class MessagesController < ApplicationController
  # Read messages.
  def index
    @message = Message.new
  end

  # Send a new message
  def create
    @message = Message.create message_params
    render status: 201
  end
end
