class Admin::PerformancesDecorator < CollectionDecorator
  def fields
    super.unshift 'name'
  end
end
