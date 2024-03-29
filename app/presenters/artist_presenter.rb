# frozen_string_literal: true

class ArtistPresenter < ApplicationPresenter
  def image
    h.attachment_image_tag(
      model,
      :image_file,
      fallback: "http://placehold.it/250x250?text=#{placeholder_text}"
    )
  end

  def links
    return [] if model.links.blank?

    model.links.map do |name, href|
      Link.new name: name, href: href
    end
  end

  def title
    model.name
  end
end
