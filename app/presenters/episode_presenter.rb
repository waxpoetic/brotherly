# frozen_string_literal: true
class EpisodePresenter < ApplicationPresenter
  # Hard-set width of videos.
  VIDEO_WIDTH = 640

  # Content type of video streams.
  VIDEO_TYPE = 'application/x-mpegURL'

  # Protocol used for transcode streams.
  TRANSCODE_PROTOCOL = 'https://'

  def performances
    model.performances.play_order
  end

  def artists
    performances.map(&:artist).map(&:present)
  end

  def related_videos
    @related_videos ||= performances + Episode.latest.without(model)
  end

  def recommendations
    @recommendations ||= VideoPresenter.wrap(related_videos)
  end

  def recommendations
    @performances ||= recommendations.map do |recommendation|
      present recommendation, with: VideoPresenter
    end
  end

  def video_cache_key
    archived? ? :archive : :stream
  end

  def includes_links?
    model.facebook_url.present? || model.eventbrite_url.present?
  end

  def flyer
    h.attachment_image_tag(
      model,
      :flyer_file,
      fallback: fallback_flyer,
      title: model.name,
      alt: model.name,
      class: 'flyer-file'
    )
  end

  def poster_url
    h.attachment_url(
      model,
      :flyer_file,
      fallback: "http://placehold.it/640x480?text=#{placeholder_text}"
    )
  end

  def cover_image_url
    h.attachment_url(
      model,
      :flyer_file,
      :fill,
      240,
      160,
      fallback: cover_image_fallback
    )
  end

  def flyer_image_url
    h.attachment_url(model, :flyer_file, fallback: cover_image_fallback)
  end

  def autoplay
    'autoplay' if autoplay?
  end

  def stream_url
    return unless model.youtube_id.present?
    "http://www.youtube.com/embed/#{model.youtube_id}"
  end

  def audio
    h.attachment_url model, :audio_file
  end

  def audio?
    model.audio_file_id.present?
  end

  def video?
    model.video_url.present?
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

  def autoplay?
    return false unless model.starts_at.present?
    return true unless model.ends_at.present?
    model.starts_at <= Time.current && model.ends_at >= Time.current
  end

  def fallback_flyer
    "http://placehold.it/240x320?text=#{placeholder_text}"
  end

  def cover_image_fallback
    "http://placehold.it/240x160?text=#{placeholder_text}"
  end
end
