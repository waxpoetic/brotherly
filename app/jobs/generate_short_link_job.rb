class GenerateShortLinkJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    Bitly::ShortLink.create url: episode.eventbrite_url do |link|
      episode.update short_link_url: link.short_url
    end
  end
end
