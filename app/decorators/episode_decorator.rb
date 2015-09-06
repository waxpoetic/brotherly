class EpisodeDecorator < Draper::Decorator
  delegate_all

  def video_tag
    h.content_tag :iframe, video_tag_options, 'Connecting...'
  end

  def youtube_url
    model.youtube_url + "?autoplay=true"
  end

  def current_title
    model.future? ? 'next episode...' : 'latest episode'
  end

  def enclosure(kind='audio')
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

  def title
    model.name.titleize
  end

  def subtitle
    h.truncate model.description, length: 150
  end

  def published_at
    model.published_at.to_s(:rfc822)
  end

  def posted_at
    h.distance_of_time_ago_in_words model.published_at
  end

  def video_tag_options
    {
      id: 'stream',
      width: 560,
      height: 315,
      src: youtube_url,
      frameborder: 0,
      allowfullscreen: true
    }
  end
end
