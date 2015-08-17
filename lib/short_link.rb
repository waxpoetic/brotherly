class ShortLink
  include Rails.application.routes.url_helpers

  attr_reader :episode

  def initialize(episode)
    @episode = episode
  end

  def url
    link.short_url
  end

  def link
    @link ||= Bitly.client.shorten episode_url(episode), history: 1
  end
end
