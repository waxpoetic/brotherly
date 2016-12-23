# frozen_string_literal: true
class ArtistPresenter < ApplicationPresenter
  def image
    h.attachment_image_tag(
      model,
      :image_file,
      fallback: fallback_image_url
    )
  end

  def fallback_image_url
    "http://placehold.it/250x250?text=#{placeholder_text}"
  end

  def preview_image
    h.attachment_image_tag(
      model, :image, :fill, 250, 250, fallback: fallback_image_url
    )
  end

  def links
    return [] unless model.links.present?
    model.links.map do |name, href|
      Link.new name: name, href: href
    end
  end

  def title
    model.name
  end
end
