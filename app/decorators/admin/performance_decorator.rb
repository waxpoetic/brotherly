class Admin::PerformanceDecorator < AdminDecorator
  decorates Performance
  delegate_all

  def title
    "#{artist.name} at #{episode.name}"
  end
end
