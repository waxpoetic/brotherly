# frozen_string_literal: true

class ArtistPresenter < ApplicationPresenter
  def image_url(options = {})
    if model.image_file.attached? && options.any?
      h.rails_blob_url model.image_file.variant(options)
    elsif model.image_file.attached?
      h.rails_blob_url model.image_file.attachment
    else
      "http://placehold.it/250x250?text=#{placeholder_text}"
    end
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
