class PodcastEpisodeDecorator < EpisodeDecorator
  def published_at
    model.published_at.to_s(:rfc822)
  end

  def length
    audio_file.download.size
  end

  def explicit
    'no'
  end

  def duration
    length / 60
  end

  def title
    model.name
  end

  def subtitle
    h.truncate model.description, length: 100
  end
end
