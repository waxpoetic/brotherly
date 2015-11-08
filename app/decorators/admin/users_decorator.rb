class Admin::UsersDecorator < CollectionDecorator
  def fields
    %w(name email role)
  end
end
