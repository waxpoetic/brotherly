class Admin::PerformanceDecorator < AdminDecorator
  decorates Performance
  delegate_all

  def title
    model.name
  end
end
