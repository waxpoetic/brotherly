class PerformanceDecorator < ApplicationDecorator
  delegate_all

  delegate :name, to: :artist, prefix: true

  def cover_image
    "http://placehold.it/960x320?text=#{placeholder_text}"
  end

  def downloadable?
    model.audio_file.present?
  end

  def title
    model.name
  end

  def video?
    model.youtube_id.present?
  end

  def audio?
    model.mixcloud_url.present?
  end

  def youtube_url
    "http://www.youtube.com/?v=#{model.youtube_id}"
  end

  def youtube_embed_url
    "http://www.youtube.com/embed/#{model.youtube_id}"
  end
end
