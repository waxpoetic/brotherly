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
    h.attachment_url model, :image, fallback: episode.poster_url
  end

  def image
    h.attachment_image_tag model, :image, fallback: episode.poster_url
  end

  def video
    model.video_url
  end

  def cover_image_url
    "http://placehold.it/240x160?text=#{placeholder_text}"
  end

  def audio
    h.attachment_url model, :audio_file
  end

  def downloadable?
    model.audio_file.present?
  end

  def title
    model.name
  end

  def episode
    EpisodePresenter.new(model.episode)
  end
end
