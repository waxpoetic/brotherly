source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '~> 4.2'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'sidekiq'
gem 'controller_resources'
gem 'responders'
gem 'active_model_serializers'
gem 'draper'
gem 'simple_form'
gem 'devise'
gem 'haml-rails'
gem 'pundit'
gem 'refile'
gem 'refile-s3'
gem 'eventbrite-client', github: 'waxpoetic/eventbrite-client.rb'
gem 'youtube_it'
gem 'bitly'

gem 'sass-rails'
gem 'coffee-rails'
gem 'foundation-rails'
gem 'uglifier',         '~> 1.3'
gem 'jquery-rails'
gem 'autoprefixer-rails'
gem 'turbolinks' #, github: 'rails/turbolinks'

#source 'https://rails-assets.org'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-sidekiq'
  gem 'rubocop'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'asset_sync'
  gem 'syslogger'
end
