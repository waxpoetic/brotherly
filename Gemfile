source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '~> 5'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'controller_resources', github: 'tubbo/controller_resources', branch: 'master'
gem 'responders'
gem 'active_model_serializers'
gem 'active_model-jobs'
gem 'draper'
gem 'activemodel-serializers-xml'
gem 'simple_form'
gem 'devise'
gem 'haml-rails'
gem 'refile', github: 'refile/refile'
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
gem 'sass-rails', github: 'rails/sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'jquery-turbolinks'
gem 'turbolinks'
# gem 'administrate', github: 'thoughtbot/administrate', branch: 'rails-5'

source 'https://rails-assets.org' do
  gem 'rails-assets-foundation', '~> 5'
  gem 'rails-assets-lodash'
end

group :development do
  # gem 'meta_request'
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
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'rspec-core', github: 'rspec/rspec-core'
  gem 'rspec-expectations', github: 'rspec/rspec-expectations'
  gem 'rspec-mocks', github: 'rspec/rspec-mocks'
  gem 'rspec-support', github: 'rspec/rspec-support'
  gem 'capybara'
  gem 'poltergeist'
  gem 'codeclimate-test-reporter', require: nil
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails', github: 'redis-store/redis-rails'
  gem 'redis-activesupport', github: 'redis-store/redis-activesupport'
  gem 'redis-rack-cache', github: 'redis-store/redis-rack-cache'
  gem 'rails_12factor'
  gem 'sidekiq'
  gem 'sinatra', require: false, github: 'sinatra/sinatra'
  gem 'refile-s3'
  gem 'airbrake'
end
