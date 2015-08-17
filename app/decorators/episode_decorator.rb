class EpisodeDecorator < Draper::Decorator
  delegate_all

  def title
    model.future? ? 'next episode...' : 'latest episode'
  end

  def enclosure(kind)
    recording = model.send "#{kind}_recording"
    {
      url: recording.url,
      length: recording.file_size,
      type: recording.content_type
    }
  end

  def explicit
    model.is_explicit? ? 'yes' : 'no'
  end

  def subtitle
    h.truncate episode.description, length: 150
  end

  def published_at
    model.published_at.to_s(:rfc822)
  end
end
