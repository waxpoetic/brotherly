# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5'
gem 'pg'
gem 'puma'
gem 'controller_resources'
gem 'responders'
gem 'active_model-jobs'
gem 'makeover'
gem 'simple_form'
gem 'devise'
gem 'slim-rails'
gem 'refile', git: 'https://github.com/refile/refile.git', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'eventbrite-client', git: 'https://github.com/waxpoetic/eventbrite-client.rb.git'
gem 'bitly'
gem 'friendly_id'
gem 'foreman'
gem 'newrelic_rpm'
gem 'librato-rails'
gem 'email_validator'
gem 'gibbon'
gem 'semver'
gem 'aws-sdk'
gem 'sitemap_generator'
gem 'videojs_rails'
gem 'titleist'
gem 'rack-cors'
gem 'halt'

gem 'lodash-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'turbolinks'
gem 'administrate', git: 'https://github.com/thoughtbot/administrate.git'
gem 'rack-env-notifier'
gem 'bourbon'
gem 'neat'
gem 'normalize-rails'
gem 'jquery-slick-rails'

group :development do
  gem 'meta_request'
  gem 'web-console', '~> 2.0'
  gem 'rubocop'
  gem 'scss_lint', require: false
  gem 'haml2slim', require: false
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
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara'
  gem 'poltergeist'
  gem 'codeclimate-test-reporter', require: nil
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails', '~> 5'
  gem 'redis-rack-cache', '2.0.0.pre'
  gem 'rails_12factor'
  gem 'sidekiq'
  gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', require: false
  gem 'refile-s3', git: 'https://github.com/refile/refile-s3.git'
  gem 'airbrake'
end
