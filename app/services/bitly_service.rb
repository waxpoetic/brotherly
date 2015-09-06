class BitlyService < Brotherly::Service
  remote Brotherly::ShortLink
  local :episode

  after_create :update_episode

  def attributes
    { url: url }
  end

  private

  def update_episode
    episode.update short_url: remote.url
  end

  def url
    Rails.application.routes.episodes_path episode
  end
end
