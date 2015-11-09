class PerformanceDecorator < ApplicationDecorator
  delegate_all

  def artist_name
    artist.name
  end

  def cover_image
    "http://placehold.it/960x320?text=#{placeholder_text}"
  end

  def audio
    h.attachment_url model, :audio_file
  end

  def downloadable?
    model.audio_file.present?
  end
end
