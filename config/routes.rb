Rails.application.routes.draw do
  namespace :admin do
    resources :episodes
    resources :users
  end
  get '/admin' => 'admin/base#index'

  resources :artists, only: [:index, :show]
  resources :episodes, only: [:index, :show] do
    resources :performances, only: [:index, :show]
  end

  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  root 'episodes#latest'
end
