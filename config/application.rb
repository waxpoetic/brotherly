require File.expand_path('../boot', __FILE__)

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails'

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile
Bundler.require :default, Rails.env

require 'brotherly'

module Brotherly
  class Application < Rails::Application
    # Use EST as our local time zone. (UTC is default)
    config.time_zone = 'Eastern Time (US & Canada)'

    # Page and podcast metadata.
    config.name = 'brother.ly'
    config.description = "Philadelphia's monthly electronic music showcase"
    config.keywords = %w(live electronic music philadelphia)
    config.founding_year = 2015

    # Whether the podcast is explicit or not.
    config.explicit = 'clean'

    # Capacity for when new events are created.
    config.capacity = 200

    # Eager-load application library code.
    config.eager_load_namespaces << Brotherly
    config.autoload_paths << Rails.root.join('lib')

    # Seed tables in development.
    config.seeds = %w(artists episodes performances)

    # Configure CORS headers for font assets.
    config.font_assets.origin = '*'

    # Global configuration for pg search
    config.search = {
      tsearch: {
        prefix: true,
        any_word: true
      },
      trigram: {}
    }
  end
end
