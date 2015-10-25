class Admin::SubscribersController < ApplicationController
  resource :subscriber do
    permit :name, :email
  end
end
