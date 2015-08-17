Rails.application.routes.draw do
  namespace :admin do
    resources :episodes
    resources :users
  end
  get '/admin' => 'admin/base#index'

  resources :artists, only: [:index, :show]
  resources :episodes, only: [:index, :show] do
    collection do
      get ':kind' => 'podcasts#index', format: 'rss'
    end
    resources :performances, only: [:show]
  end

  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  root 'episodes#latest'
end
