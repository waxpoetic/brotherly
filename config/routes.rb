Rails.application.routes.draw do
  namespace :admin do
    resources :artists
    resources :episodes
    resources :performances
    resources :subscribers
    resources :users
  end
  get '/admin' => 'admin#dashboard', as: :admin_root

  resources :artists, only: [:index, :show]
  resources :episodes, only: [:index, :show] do
    resources :performances, only: [:show]
  end
  resources :subscribers
  devise_for :users, path_names: {
    sign_in:  'login',
    sign_out: 'logout',
    sign_up:  'signup'
  }

  resource :search, only: [:show]

  root 'episodes#current'
end
