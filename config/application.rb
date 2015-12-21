require File.expand_path('../boot', __FILE__)

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require "rails"

%w(
  active_record
  action_controller
  action_view
  action_mailer
  active_job
  sprockets
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end

# Require the gems listed in Gemfile
Bundler.require :default, Rails.env

require 'brotherly'
require 'eventbrite'
require 'youtube'
require 'mailchimp'

module Brotherly
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Use EST as our local time zone. (UTC is default)
    config.time_zone = 'Eastern Time (US & Canada)'

    # Raise errors during transactional callback methods. This will be
    # the default in upcoming versions of Rails.
    config.active_record.raise_in_transactional_callbacks = true

    # Always show debug logs, because we filter them out in syslog.
    config.log_level = :debug

    # Use localhost as mail server (for Devise)
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    # Page and podcast metadata.
    config.name = 'brother.ly'
    config.description = "A monthly electronic music showcase."
    config.keywords = %w(live electronic music philadelphia)
    config.founding_year = 2015

    # Whether the podcast is explicit or not.
    config.explicit = 'clean'

    # Capacity for when new events are created.
    config.capacity = 200

    # Eager-load library code.
    config.eager_load_namespaces << Brotherly
    config.eager_load_namespaces << Eventbrite
    config.eager_load_namespaces << Youtube
    config.autoload_paths << Rails.root.join('lib')

    # Seed tables in development.
    config.seeds = %w(artists episodes performances)

    # Configure CORS headers for font assets.
    config.font_assets.origin = '*'
  end
end
