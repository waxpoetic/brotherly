module EpisodesHelper
  def latest_cache_key(collection_name)
    collection = send collection_name
    max_updated_at = collection.maximum(:updated_at).try(:utc)
    latest_update = max_updated_at.try(:to_s, :number)
    "footer/recent_episodes-#{latest_update}"
  end

  def podcast_publish_date
    episodes.last.published_at
  end

  def podcast_cache_key(section = nil)
    max_updated_at = episodes.last.updated_at.try(:utc)
    last_updated_at = max_updated_at.try(:to_s, :number) || '0'

    if section
      "podcast/#{last_updated_at}/#{section}"
    else
      "podcast/#{last_updated_at}"
    end
  end

  def next_or_last_episode
    if current_episode.future?
      t(:next_episode, scope: :nav)
    else
      t(:latest_episode, scope: :nav)
    end
  end
end
