require 'sidekiq/web' if defined? Sidekiq

Rails.application.routes.draw do
  resources :artists, only: [:index, :show]
  resources :episodes, only: [:index, :show] do
    collection do
      get :upcoming
      get :past
    end
    resources :performances, only: [:show]
  end
  resources :subscribers
  devise_for :users, path_names: {
    sign_in:  'login',
    sign_out: 'logout',
    sign_up:  'signup'
  }

  resource :search, only: [:show]

  if defined? Sidekiq
    authenticate :user, ->(u) { u.is_admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  get :about, to: 'pages#about'

  root to: 'pages#home'
end
