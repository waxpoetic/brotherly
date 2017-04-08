# == Route Map
#
#                 Prefix Verb   URI Pattern                                      Controller#Action
#         admin_episodes GET    /admin/episodes(.:format)                        admin/episodes#index
#                        POST   /admin/episodes(.:format)                        admin/episodes#create
#      new_admin_episode GET    /admin/episodes/new(.:format)                    admin/episodes#new
#     edit_admin_episode GET    /admin/episodes/:id/edit(.:format)               admin/episodes#edit
#          admin_episode GET    /admin/episodes/:id(.:format)                    admin/episodes#show
#                        PATCH  /admin/episodes/:id(.:format)                    admin/episodes#update
#                        PUT    /admin/episodes/:id(.:format)                    admin/episodes#update
#                        DELETE /admin/episodes/:id(.:format)                    admin/episodes#destroy
#     admin_performances GET    /admin/performances(.:format)                    admin/performances#index
#                        POST   /admin/performances(.:format)                    admin/performances#create
#  new_admin_performance GET    /admin/performances/new(.:format)                admin/performances#new
# edit_admin_performance GET    /admin/performances/:id/edit(.:format)           admin/performances#edit
#      admin_performance GET    /admin/performances/:id(.:format)                admin/performances#show
#                        PATCH  /admin/performances/:id(.:format)                admin/performances#update
#                        PUT    /admin/performances/:id(.:format)                admin/performances#update
#                        DELETE /admin/performances/:id(.:format)                admin/performances#destroy
#          admin_artists GET    /admin/artists(.:format)                         admin/artists#index
#                        POST   /admin/artists(.:format)                         admin/artists#create
#       new_admin_artist GET    /admin/artists/new(.:format)                     admin/artists#new
#      edit_admin_artist GET    /admin/artists/:id/edit(.:format)                admin/artists#edit
#           admin_artist GET    /admin/artists/:id(.:format)                     admin/artists#show
#                        PATCH  /admin/artists/:id(.:format)                     admin/artists#update
#                        PUT    /admin/artists/:id(.:format)                     admin/artists#update
#                        DELETE /admin/artists/:id(.:format)                     admin/artists#destroy
#      admin_subscribers GET    /admin/subscribers(.:format)                     admin/subscribers#index
#                        POST   /admin/subscribers(.:format)                     admin/subscribers#create
#   new_admin_subscriber GET    /admin/subscribers/new(.:format)                 admin/subscribers#new
#  edit_admin_subscriber GET    /admin/subscribers/:id/edit(.:format)            admin/subscribers#edit
#       admin_subscriber GET    /admin/subscribers/:id(.:format)                 admin/subscribers#show
#                        PATCH  /admin/subscribers/:id(.:format)                 admin/subscribers#update
#                        PUT    /admin/subscribers/:id(.:format)                 admin/subscribers#update
#                        DELETE /admin/subscribers/:id(.:format)                 admin/subscribers#destroy
#            admin_users GET    /admin/users(.:format)                           admin/users#index
#                        POST   /admin/users(.:format)                           admin/users#create
#         new_admin_user GET    /admin/users/new(.:format)                       admin/users#new
#        edit_admin_user GET    /admin/users/:id/edit(.:format)                  admin/users#edit
#             admin_user GET    /admin/users/:id(.:format)                       admin/users#show
#                        PATCH  /admin/users/:id(.:format)                       admin/users#update
#                        PUT    /admin/users/:id(.:format)                       admin/users#update
#                        DELETE /admin/users/:id(.:format)                       admin/users#destroy
#             admin_root GET    /admin(.:format)                                 admin/episodes#index
#                artists GET    /artists(.:format)                               artists#index
#                 artist GET    /artists/:id(.:format)                           artists#show
#    episode_performance GET    /episodes/:episode_id/performances/:id(.:format) performances#show
#      upcoming_episodes GET    /episodes/upcoming(.:format)                     episodes#upcoming
#         player_episode GET    /episodes/:id/player(.:format)                   episodes#player
#               episodes GET    /episodes(.:format)                              episodes#index
#                episode GET    /episodes/:id(.:format)                          episodes#show
#            subscribers GET    /subscribers(.:format)                           subscribers#index
#                        POST   /subscribers(.:format)                           subscribers#create
#         new_subscriber GET    /subscribers/new(.:format)                       subscribers#new
#        edit_subscriber GET    /subscribers/:id/edit(.:format)                  subscribers#edit
#             subscriber GET    /subscribers/:id(.:format)                       subscribers#show
#                        PATCH  /subscribers/:id(.:format)                       subscribers#update
#                        PUT    /subscribers/:id(.:format)                       subscribers#update
#                        DELETE /subscribers/:id(.:format)                       subscribers#destroy
#       new_user_session GET    /users/login(.:format)                           devise/sessions#new
#           user_session POST   /users/login(.:format)                           devise/sessions#create
#   destroy_user_session DELETE /users/logout(.:format)                          devise/sessions#destroy
#      new_user_password GET    /users/password/new(.:format)                    devise/passwords#new
#     edit_user_password GET    /users/password/edit(.:format)                   devise/passwords#edit
#          user_password PATCH  /users/password(.:format)                        devise/passwords#update
#                        PUT    /users/password(.:format)                        devise/passwords#update
#                        POST   /users/password(.:format)                        devise/passwords#create
#                  about GET    /about(.:format)                                 pages#about
#               workshop GET    /workshop(.:format)                              pages#workshop
#               calendar GET    /calendar(.:format)                              pages#calendar
#         oauth2callback GET    /oauth2callback(.:format)                        events#authorize_google_api
#                   root GET    /                                                pages#home
#             refile_app        /attachments                                     #<Refile::App app_file="/Users/tscott/Code/brotherly/vendor/bundle/bundler/gems/refile-d7a42dcd7cf6/lib/refile/app.rb">
#

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
  get :workshop, to: 'pages#workshop'

  get :calendar, to: 'pages#calendar'
  # get :calendar, to: 'events#index', as: :calendar
  # get "calendar/events/:id", to: 'events#show', as: :event

  get :oauth2callback, to: 'events#authorize_google_api'

  root to: 'pages#home'
end
