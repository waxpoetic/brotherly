class Link
  attr_reader :name, :href, :artist

  def initialize(name: '', href: '', artist: nil)
    @name = name
    @href = href
    @artist = artist
  end

  def icon
    if name == 'website'
      :globe
    else
      name.to_sym
    end
  end

  def about
    "#{artist.name} on #{link.titleize}"
  end

  def title
    name.titleize
  end
end
