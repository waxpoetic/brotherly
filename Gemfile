source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '~> 4.2'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'controller_resources'
gem 'responders'
gem 'active_model_serializers'
gem 'active_model-jobs'
gem 'draper'
gem 'simple_form'
gem 'devise'
gem 'haml-rails'
gem 'refile', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'eventbrite-client', github: 'waxpoetic/eventbrite-client.rb'
gem 'bitly'
gem 'friendly_id'
gem 'foreman'
gem 'newrelic_rpm'
gem 'librato-rails'
gem 'email_validator'
gem 'gibbon'
gem 'ransack'
gem 'kaminari'
gem 'semver'
gem 'aws-sdk'
gem 'youtube_it'
gem 'twitter'

gem 'lodash-rails'
gem 'sass', '~> 3.3'
gem 'sass-rails'
gem 'coffee-rails'
# gem 'foundation-rails', '5.5.2.1'
gem 'uglifier'
gem 'jquery-rails'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'jquery-turbolinks'
gem 'turbolinks', github: 'rails/turbolinks'
gem 'administrate', github: 'thoughtbot/administrate'
gem 'sprockets-rails', '~> 2'

source 'https://rails-assets.org' do
  gem 'rails-assets-foundation', '~> 5'
end

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'web-console', '~> 2.0'
  gem 'rubocop'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-sidekiq'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'codeclimate-test-reporter', require: nil
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'redis-rack-cache'
  gem 'rails_12factor'
  gem 'sidekiq'
  gem 'sinatra', require: false
  gem 'refile-s3'
  gem 'airbrake'
end
