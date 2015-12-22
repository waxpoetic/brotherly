class ArtistDecorator < ApplicationDecorator
  delegate_all

  def image
    h.attachment_image_tag(
      model,
      :image_file,
      fallback: "http://placehold.it/250x250?text=#{placeholder_text}"
    )
  end

  def title
    model.name
  end
end
