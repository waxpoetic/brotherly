# frozen_string_literal: true

class PerformancePresenter < ApplicationPresenter
  delegate :name, to: :artist, prefix: true

  def url
    h.episode_performance_path(model.episode, model)
  end

  def caption
    model.artist.name
  end

  def poster_url
    return episode.poster_url unless model.image.attached?

    h.rails_blob_url model.image
  end

  def image
    h.image_tag image_url
  end

  def image_url
    return cover_image_url unless model.image.attached?

    h.rails_blob_url(model.image)
  end

  def video
    model.video_url
  end

  def cover_image_url
    "http://placehold.it/240x160?text=#{placeholder_text}"
  end

  def audio
    h.rails_blob_url model.audio_file if downloadable?
  end

  def downloadable?
    model.audio_file.attached?
  end

  def title
    model.name
  end

  def episode
    EpisodePresenter.new(model.episode)
  end
end
