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
    '$0.00'
  end
end
