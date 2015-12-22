class YoutubeService < Brotherly::Service
  remote Youtube::Video
  local :episode
  param :youtube_url

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
