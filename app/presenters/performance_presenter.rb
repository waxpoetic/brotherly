# frozen_string_literal: true
class PerformancePresenter < ApplicationPresenter
  delegate :name, to: :artist, prefix: true

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
end
