require 'service'

class YoutubeService < Service
  remote Youtube::Video

  def attributes
    local.attributes.slice(
      :name, :starts_at, :ends_at
    )
  end

  delegate :url, to: :remote
end
