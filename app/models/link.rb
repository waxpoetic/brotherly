# frozen_string_literal: true
class Link
  attr_reader :name, :href

  def initialize(name: '', href: '')
    @name = name
    @href = href
  end

  def icon
    if name == 'website'
      :globe
    else
      name.to_sym
    end
  end

  def title
    name.titleize
  end
end
