class ArtistDecorator < ApplicationDecorator
  delegate_all

  def image
    h.attachment_url model, :image_file, fallback: "http://placehold.it/250x250?text=#{placeholder_text}"
  end

  def title
    model.name
  end
end
