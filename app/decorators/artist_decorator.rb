class ArtistDecorator < ApplicationDecorator
  delegate_all

  def image_url
    'http://placehold.it/250x250'
  end

  def title
    model.name
  end
end
