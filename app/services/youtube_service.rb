require 'service'

class YoutubeService < Service
  remote Youtube::Video
  local :episode

  CATEGORY = 'Music'

  def attributes
    episode.attributes.slice(:description).merge(
      category: CATEGORY,
      keywords: Rails.application.config.keywords,
      title: episode.name
    )
  end

  delegate :url, to: :remote
end
