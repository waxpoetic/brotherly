source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '~> 5.0.0.rc1'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'controller_resources', github: 'tubbo/controller_resources', branch: 'master'
gem 'responders'
gem 'active_model_serializers'
gem 'active_model-jobs'
gem 'activemodel-serializers-xml'
gem 'draper', github: 'drapergem/draper', branch: 'master'
gem 'simple_form'
gem 'devise', github: 'plataformatec/devise', branch: 'master'
gem 'haml-rails' #, github: 'indirect/haml-rails'
gem 'refile', require: 'refile/rails', github: 'refile/refile'
gem 'refile-mini_magick'
gem 'eventbrite-client', github: 'waxpoetic/eventbrite-client.rb', branch: 'master'
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

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'font_assets'
gem 'jquery-turbolinks'
gem 'turbolinks', github: 'rails/turbolinks'
gem 'administrate', github: 'thoughtbot/administrate', branch: 'master'
gem 'lodash-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-foundation', '~> 5'
end

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'web-console'
  gem 'rubocop'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-sidekiq'
  gem 'spring-commands-rubocop'
  gem 'listen', '~> 3.0.5'
  gem 'spring-watcher-listen'
end

group :test do
  %w[rails core expectations mocks support].each do |lib|
    gem "rspec-#{lib}", github: "rspec/rspec-#{lib}", branch: 'master'
  end
  gem 'capybara', github: 'jnicklas/capybara'
  gem 'poltergeist'
  gem 'codeclimate-test-reporter', require: nil
end

group :production, :staging do
  gem 'rack-cache'
  gem 'redis'
  gem 'redis-rails', github: 'redis-store/redis-rails', branch: 'master'
  gem 'redis-actionpack', github: 'redis-store/redis-actionpack', ref: 'v5.0.0.pre'
  gem 'rails_12factor'
  gem 'sidekiq'
  gem 'sinatra', require: false, github: 'sinatra/sinatra'
  gem 'refile-s3'
  gem 'airbrake'
end
