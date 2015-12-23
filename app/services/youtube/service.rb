module Youtube
  class Service < Brotherly::Service
    remote Video
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
end
