class PerformanceDecorator < ApplicationDecorator
  delegate_all

  def cover_image_url
    'http://placehold.it/150x150'
  end

  def artist_name
    artist.name
  end

  def title
    "#{artist.name} at #{episode.name}"
  end

  def audio_recording_url
    h.attachment_url model, :audio_recording
  end

  def video_recording_url
    h.attachment_url model, :video_recording
  end
end
