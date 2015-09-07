class ArtistDecorator < Draper::Decorator
  delegate_all

  def image_url
    'http://placehold.it/250x250'
  end
end
