# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

# Load support files
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Use fixtures to set up test data
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all
  config.use_transactional_fixtures = true

  # If type is not defined, infer it from the file location
  config.infer_spec_type_from_file_location!

  # Load Devise test helpers into controller and request specs
  config.include Devise::TestHelpers, type: [:controller, :request]

  # Load Warden test helpers into feature specs
  config.include Warden::Test::Helpers, type: :feature
  config.include WardenLoginHelper, type: :feature

  # Use the same admin login helper in all front-end tests
  config.include AdminLoginHelper, type: [:controller, :request, :feature]

  config.around type: :feature do |example|
    Warden.test_mode!
    example.run
    Warden.test_reset!
  end
end
