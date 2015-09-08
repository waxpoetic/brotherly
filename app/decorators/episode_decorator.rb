class EpisodeDecorator < Draper::Decorator
  delegate_all

  def cache_key_for(section)
    [ model.cache_key, section ].join('/')
  end

  def date
    starts_at.to_date
  end

  def video_tag
    h.content_tag :iframe, video_tag_options do
      'Connecting...'
    end
  end

  def performances
    model.performances.map(&:decorate)
  end

  def preview_image_url
    'http://placehold.it/240x320'
  end

  def youtube_embed_url
    return unless model.youtube_url
    model.youtube_url + "?autoplay=true"
  end

  def current_title
    model.future? ? 'next episode...' : 'latest episode'
  end

  def has_video?
    model.youtube_url.present?
  end

  def audio_url
    h.attachment_url model, :audio_recording
  end

  def video_url
    h.attachment_url model, :video_recording
  end

  def has_audio?
    model.mixcloud_url.present?
  end

  def show_ticket_link?
    model.future? && model.eventbrite_url.present?
  end

  def show_facebook_event?
    model.future? && model.facebook_url.present?
  end

  def show_mixcloud_link?
    !model.future? && model.mixcloud_url.present?
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
    model.name
  end

  def subtitle
    h.truncate model.description, length: 100
  end

  def published_at
    model.published_at.to_s(:rfc822)
  end

  def posted_at
    return if model.published_at.present?
    h.distance_of_time_in_words model.published_at
  end

  def video_tag_options
    {
      id: 'stream',
      width: 1000,
      height: 640,
      src: youtube_embed_url,
      frameborder: 0,
      allowfullscreen: true
    }
  end
end
