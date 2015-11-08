class Admin::PerformancesDecorator < CollectionDecorator
  def fields
    [:name, :created_at, :updated_at]
  end
end
