class Admin::UsersController < AdminController
  resource :user do
    permit :name, :email, :password, :password_confirmation
  end
end
