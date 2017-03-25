class EventsController < ApplicationController
  def index
    @events = Event.recent
    respond_with @events
  end

  def show
    @event = Event.find params[:id]
    respond_with @event
  end

  def authorize_google_api
    @calendar = Event.calendar

    if @calendar.authorized?
      redirect_to root_path, notice: 'Google API has already been authorized' and return
    end

    if @calendar.login params[:code]
      redirect_to root_path, notice: 'Google API has been authorized'
    else
      redirect_to root_path, alert: 'Google API could not be authorized'
    end
  end
end
