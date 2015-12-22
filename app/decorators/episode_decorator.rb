class EpisodeDecorator < ApplicationDecorator
  delegate_all

  def artists
    model.artists.map(&:decorate)
  end

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

  def flyer
    h.attachment_url model, :flyer_file, \
      fallback: "http://placehold.it/240x320?text=#{placeholder_text.gsub('brother.ly+', '')}"
  end

  def youtube_embed_url
    return unless model.youtube_url.present?
    # if Rails.env.production?
    #   model.youtube_url + "?autoplay=true"
    # else
    model.youtube_url
    # end
  end

  def current_title
    model.future? ? 'next episode...' : 'latest episode'
  end

  def audio
    h.attachment_url model, :audio_file
  end

  def has_audio?
    model.audio_file_id.present?
  end

  def has_video?
    model.youtube_url.present?
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

  def enclosure
    {
      url: audio,
      length: audio_file.file_size,
      type: audio_file.content_type
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
      width: 1014,
      height: 640,
      src: youtube_embed_url,
      frameborder: 0,
      allowfullscreen: true
    }
  end
end
