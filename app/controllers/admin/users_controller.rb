class Admin::UsersController < Admin::BaseController
  resource :user do
    modify :name, :email, :password, :password_confirmation
    search :name, :email
  end

  def index
    respond_with users
  end

  def show
    respond_with user
  end

  def new
    render 'new'
  end

  def create
    user.save
    respond_with user
  end

  def update
    user.update(edit_params)
    respond_with user
  end

  def destroy
    user.destroy
    respond_with user
  end
end
