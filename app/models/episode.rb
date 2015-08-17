class Episode < ActiveRecord::Base
  has_many :artists, through: :performances

  after_create :add_youtube_live_event, :add_eventbrite_ticket_link

  private

  def add_youtube_live_event
    AddYoutubeEventJob.perform_later self
  end

  def add_eventbrite_ticket_link
    AddTicketLinkJob.perform_later self
  end
end
