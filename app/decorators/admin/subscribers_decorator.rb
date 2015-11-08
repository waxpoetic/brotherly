class Admin::SubscribersDecorator < CollectionDecorator
  def fields
    %w(name email created_at)
  end
end
