# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

gem 'active_model-jobs'
gem 'aws-sdk'
gem 'bitly'
gem 'controller_resources'
gem 'devise'
gem 'email_validator'
gem 'foreman'
gem 'friendly_id'
gem 'gibbon'
gem 'halt'
gem 'jquery-slick-rails'
gem 'librato-rails'
gem 'makeover'
gem 'newrelic_rpm'
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails', '~> 5'
gem 'refile', git: 'https://github.com/refile/refile.git', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'responders'
gem 'semver'
gem 'simple_form'
gem 'sitemap_generator'
gem 'slim-rails'
gem 'titleist'
gem 'videojs_rails'
gem 'google-api-client'

gem 'administrate', git: 'https://github.com/thoughtbot/administrate.git'
gem 'autoprefixer-rails'
gem 'bourbon'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'jquery-rails'
gem 'lodash-rails'
gem 'neat'
gem 'normalize-rails'
gem 'fullpage-rails'

group :development do
  gem 'haml2slim', require: false
  gem 'meta_request'
  gem 'rubocop'
  gem 'scss_lint', require: false
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-sidekiq'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: nil
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-rails', '~> 3.5'
  gem 'vcr'
  gem 'webmock'
  gem 'rails-controller-testing'
end

group :production do
  gem 'airbrake'
  gem 'rack-cache'
  gem 'rails_12factor'
  gem 'redis-rack-cache'
  gem 'redis-rails', '~> 5'
  gem 'refile-s3', git: 'https://github.com/refile/refile-s3.git'
  gem 'sidekiq'
  gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', require: false
end
