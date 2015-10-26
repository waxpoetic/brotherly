class Admin::SubscribersController < AdminController
  resource :subscriber do
    permit :name, :email
  end
end
