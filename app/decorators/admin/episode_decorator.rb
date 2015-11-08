class Admin::EpisodeDecorator < AdminDecorator
  decorates Episode
  delegate_all

  def title
    model.name.downcase
  end

  def fields
    super << 'sales'
  end

  def sales
    model.event.total_sales_amount
  end
end
