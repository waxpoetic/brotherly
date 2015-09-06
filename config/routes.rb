Rails.application.routes.draw do
  namespace :admin do
    resources :artists
    resources :episodes do
      resources :performances
    end
    resources :users
  end
  get '/admin' => 'admin/base#index'

  resources :artists, only: [:index, :show]
  resources :episodes, only: [:index, :show] do
    resources :performances, only: [:show]
  end
  devise_for :users, path_names: {
    sign_in:  'login',
    sign_out: 'logout',
    sign_up:  'signup'
  }

  resource :search, only: [:show]

  root 'episodes#current'
end
