class PerformanceDecorator < Draper::Decorator
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
end
