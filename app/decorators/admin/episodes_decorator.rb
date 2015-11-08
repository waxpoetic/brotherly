class Admin::EpisodesDecorator < CollectionDecorator
  def fields
    %w(name published_at starts_at)
  end
end
