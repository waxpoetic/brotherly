class ArtistDecorator < ApplicationDecorator
  delegate_all

  def image
    h.attachment_image_tag(
      model,
      :image_file,
      fallback: "http://placehold.it/250x250?text=#{placeholder_text}"
    )
  end

  def links
    model.links.map do |name, href|
      Link.new name: name, href: href
    end
  end

  def link_icon(link_name)
    if link_name == 'website'
      :globe
    else
      link_name.to_sym
    end
  end

  def title
    model.name
  end
end
