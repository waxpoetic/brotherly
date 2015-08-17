require 'short_link'

class GenerateEpisodeLinkJob < ActiveJob::Base
  queue_as :short_links

  def perform(episode)
    episode.update short_url: ShortLink.new(episode).url
  end
end
