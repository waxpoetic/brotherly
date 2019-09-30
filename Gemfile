# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.2'

git_source :github do |name|
  repo = name.match?(%r{/}) ? name : "#{name}/#{name}"
  "https://github.com/#{repo}.git"
end

gem 'active_model_jobs', '~> 0.2.2'
gem 'administrate', github: 'thoughtbot/administrate'
gem 'aws-sdk'
gem 'bitly'
gem 'controller_resources'
gem 'devise'
gem 'email_validator'
gem 'foreman'
gem 'friendly_id'
gem 'gibbon'
gem 'halt'
gem 'makeover'
gem 'newrelic_rpm'
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rack-env-notifier'
gem 'rails', '~> 5.2.3'
gem 'refile', github: 'refile/refile', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'responders'
gem 'sassc-rails'
gem 'semver'
gem 'simple_form'
gem 'sitemap_generator'
gem 'slim-rails'
gem 'titleist'
gem 'uglifier'
gem 'webpacker'

group :development do
  gem 'haml2slim', require: false
  gem 'meta_request'
  gem 'rubocop'
  gem 'scss_lint', require: false
  gem 'web-console'
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
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'airbrake'
  gem 'librato-rails'
  gem 'rails_12factor'
  gem 'redis-rack-cache'
  gem 'redis-rails'
  gem 'refile-s3', github: 'refile/refile-s3'
  gem 'sidekiq'
  gem 'sinatra', '~> 2.0.5', require: false
end
