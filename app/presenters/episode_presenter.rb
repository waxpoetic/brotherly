# frozen_string_literal: true

class EpisodePresenter < ApplicationPresenter
  include Podcast

  # Hard-set width of videos.
  VIDEO_WIDTH = 640

  # Content type of video streams.
  VIDEO_TYPE = 'application/x-mpegURL'

  # Protocol used for transcode streams.
  TRANSCODE_PROTOCOL = 'https://'

  def artists
    model.performances.play_order.map(&:artist).map(&:decorate)
  end

  def performances
    model.performances.order(:starts_at).where.not(video_url: nil).map(&:decorate)
  end

  def video_cache_key
    archived? ? :archive : :stream
  end

  def includes_links?
    model.facebook_url.present? || model.eventbrite_url.present?
  end

  def flyer
    h.image_tag flyer_image_url, title: name, alt: name, class: 'flyer-file'
  end

  def poster_url
    return fallback_flyer unless flyer_file.attached?

    h.rails_blob_url(flyer_file)
  end

  def cover_image_url
    return cover_image_fallback unless flyer_file.attached?

    h.rails_blob_url flyer_file.variant(fill: '240x160')
  end

  def flyer_image_url
    return cover_image_fallback unless flyer_file.attached?

    h.rails_blob_url flyer_file.variant(fill: '240x160')
  end

  def autoplay
    'autoplay' if autoplay?
  end

  def stream_url
    return if model.youtube_id.blank?

    "http://www.youtube.com/embed/#{model.youtube_id}"
  end

  def autoplay?
    return false if model.starts_at.blank?
    return true if model.ends_at.blank?

    model.starts_at <= Time.current && model.ends_at >= Time.current
  end

  def fallback_flyer
    "http://placehold.it/240x320?text=#{placeholder_text}"
  end

  def cover_image_fallback
    "http://placehold.it/240x160?text=#{placeholder_text}"
  end
end
