class Admin::UsersDecorator < CollectionDecorator
  def fields
    %w(name email is_admin)
  end
end
