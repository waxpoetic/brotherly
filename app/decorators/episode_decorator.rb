class EpisodeDecorator < ApplicationDecorator
  delegate_all

  def artists
    model.performances.play_order.map(&:artist).map(&:decorate)
  end

  def cache_key_for(section)
    [model.cache_key, section].join('/')
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
    h.attachment_url(
      model,
      :flyer_file,
      fallback: fallback_flyer
    )
  end

  def youtube_embed_url
    return unless model.youtube_id.present?
    "http://www.youtube.com/embed/#{model.youtube_id}"
  end

  def youtube_url
    "http://www.youtube.com/?v=#{model.youtube_id}"
  end

  def current_title
    model.future? ? t(:next, scope: :episodes) : t(:latest, scope: :episodes)
  end

  def button_title
    current_title.gsub(/ episode/, '')
  end

  def audio
    h.attachment_url model, :audio_file
  end

  def audio?
    model.audio_file_id.present?
  end

  def video?
    model.youtube_id.present?
  end

  def show_ticket_link?
    model.future? && model.eventbrite_url.present?
  end

  def show_facebook_event?
    model.future? && model.facebook_url.present?
  end

  def enclosure
    {
      url: audio,
      length: audio_file.download.size,
      type: 'audio/mp3'
    }
  end

  def explicit
    'no'
  end

  def duration
    360
  end

  def title
    model.name
  end

  def subtitle
    h.truncate model.description, length: 100
  end

  def published_at
    return unless model.published_at
    model.published_at.to_s(:rfc822)
  end

  def posted_at
    return if model.published_at.present?
    h.distance_of_time_in_words model.published_at
  end

  def video_tag_options
    {
      id: 'stream',
      width: 640,
      height: 400,
      src: youtube_embed_url,
      frameborder: 0,
      allowfullscreen: true
    }
  end

  private

  def fallback_flyer
    "http://placehold.it/240x320?text=#{placeholder_text}"
  end
end
