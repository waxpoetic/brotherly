# frozen_string_literal: true

require 'sidekiq/web' if defined? Sidekiq

Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :artists, only: %i[index show]
  resources :episodes, only: %i[index show] do
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
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  if defined? Sidekiq
    authenticate :user, ->(u) { u.is_admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  get :about, to: 'pages#about'
  get :workshop, to: 'pages#workshop'
  get :calendar, to: 'pages#calendar'
  get :robots, to: 'pages#robots'

  root to: 'pages#home'
end
