# Download new events from Google Calendar and insert them as +Event+
# records.
class DownloadEventsJob < ApplicationJob
  queue_as :default

  def perform
    Event.calendar.each do |params|
      Event.create(params)
    end
  end
end
