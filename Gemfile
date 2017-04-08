# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

git_source :github do |name|
  repo = name =~ %r{/} ? name : "#{name}/#{name}"
  "https://github.com/#{repo}.git"
end

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
gem 'refile', github: 'refile/refile', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'responders'
gem 'semver'
gem 'simple_form'
gem 'sitemap_generator'
gem 'slim-rails'
gem 'titleist'
gem 'videojs_rails'
gem 'google-api-client'

gem 'administrate', github: 'thoughtbot/administrate'
gem 'autoprefixer-rails'
gem 'bourbon'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'jquery-rails'
gem 'lodash-rails'
gem 'neat'
gem 'normalize-rails'
gem 'rack-env-notifier'
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier'

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
  gem 'rails_12factor'
  gem 'redis-rack-cache', '2.0.2.pre'
  gem 'redis-rails', '~> 5'
  gem 'refile-s3', github: 'refile/refile-s3'
  gem 'sidekiq'
  gem 'sinatra', github: 'sinatra', require: false
end
