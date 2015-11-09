class Admin::PerformanceDecorator < AdminDecorator
  decorates Performance
  delegate_all
end
