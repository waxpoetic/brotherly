class Admin::PerformanceDecorator < ApplicationDecorator
  decorates Performance
  delegate_all

  def name
    "#{artist.name} at #{episode.name}"
  end
end
