require 'short_link'

class GenerateEpisodeLinkJob < ActiveJob::Base
  queue_as :short_links

  def perform(episode)
    short = ShortLink.new(episode)
    episode.update short_url: short.url
  end
end
