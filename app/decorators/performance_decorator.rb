class PerformanceDecorator < ApplicationDecorator
  include Media

  delegate_all

  delegate :name, to: :artist, prefix: true

  def cover_image
    "http://placehold.it/960x320?text=#{placeholder_text}"
  end

  def title
    model.name
  end
end
