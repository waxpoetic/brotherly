source 'https://rubygems.org'

gem 'rails', '~> 5'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'controller_resources'
gem 'responders'
gem 'active_model-jobs'
gem 'makeover'
gem 'simple_form'
gem 'devise'
gem 'slim-rails'
gem 'refile', github: 'refile/refile', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'eventbrite-client', github: 'waxpoetic/eventbrite-client.rb'
gem 'bitly'
gem 'friendly_id'
gem 'foreman'
gem 'newrelic_rpm'
gem 'librato-rails'
gem 'email_validator'
gem 'gibbon'
gem 'kaminari'
gem 'semver'
gem 'aws-sdk'
gem 'sitemap_generator'
gem 'videojs_rails'
gem 'titleist'
gem 'rack-cors'

gem 'lodash-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
# gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'turbolinks'
# gem 'administrate', github: 'thoughtbot/administrate'
gem 'sprockets-rails', '~> 2'
gem 'rack-env-notifier'
gem 'bourbon'
gem 'neat'
gem 'babel-transpiler'

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
  gem 'sinatra', github: 'sinatra/sinatra', require: false
  gem 'refile-s3', github: 'refile/refile-s3'
  gem 'airbrake'
end
