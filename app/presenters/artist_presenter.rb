# frozen_string_literal: true

class ArtistPresenter < ApplicationPresenter
  def thumbnail
    image_url(250)
  end

  def image
    image_url(500)
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

  private

  def image_url(size)
    dimensions = "#{size}x#{size}"

    if image_file.attached?
      h.rails_blob_url model.image_file.variant(fill: dimensions)
    else
      "http://placehold.it/#{dimensions}?text=#{placeholder_text}"
    end
  end
end
