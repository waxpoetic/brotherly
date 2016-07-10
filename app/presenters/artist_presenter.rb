class ArtistPresenter < ApplicationPresenter
  delegate_all

  def image
    h.attachment_image_tag(
      model,
      :image_file,
      fallback: "http://placehold.it/250x250?text=#{placeholder_text}"
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
