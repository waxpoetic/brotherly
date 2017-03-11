class EventsController < ApplicationController
  def index
    @events = Event.all
    respond_with @events
  end

  def show
    @event = Event.find params[:id]
    respond_with @event
  end
end
