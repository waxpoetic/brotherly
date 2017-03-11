# frozen_string_literal: true
require 'sidekiq/web' if defined? Sidekiq

Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :artists, only: [:index, :show]
  resources :episodes, only: [:index, :show] do
    resources :performances, only: [:show]

    collection do
      get :upcoming
    end

    member do
      get :player
    end
  end
  resources :subscribers
  devise_for :users, path_names: {
    sign_in:  'login',
    sign_out: 'logout',
    sign_up:  'signup'
  }

  if defined? Sidekiq
    authenticate :user, ->(u) { u.is_admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  get :about, to: 'pages#about'

  get :calendar, to: 'events#index', as: :calendar
  get "calendar/events/:id", to: 'events#show', as: :event

  get :oauth2callback, to: 'events#auth'

  root to: 'episodes#show', id: '_current'
end
