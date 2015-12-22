class SoundcloudService < Brotherly::Service
  remote SoundCloud::Track
  local :episode

  after_create :update_episode_soundcloud_url

  def attributes
    {
      title: episode.name,
      asset_data: audio_file.download
    }
  end

  private

  def audio_file
    @audio_file ||= Refile.store.get episode.audio_file_id
  end

  def update_episode_soundcloud_url
    episode.update soundcloud_url: remote.permalink_url
  end
end
