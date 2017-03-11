class EventsController < ApplicationController
  def index
    @events = Event.recent
    respond_with @events
  end

  def show
    @event = Event.find params[:id]
    respond_with @event
  end

  def auth
    Event.calendar.login params[:code]
    redirect_to root_path
  end
end
