# frozen_string_literal: true

require File.expand_path('boot', __dir__)

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails'

%w[
  active_record
  action_controller
  action_view
  action_mailer
  active_job
  sprockets
].each do |framework|
  require "#{framework}/railtie"
rescue LoadError
end

# Require the gems listed in Gemfile
Bundler.require :default, Rails.env

require 'brotherly'

module Brotherly
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Use EST as our local time zone. (UTC is default)
    config.time_zone = 'Eastern Time (US & Canada)'

    # Always show debug logs, because we filter them out in syslog.
    config.log_level = :debug

    # Use localhost as mail server (for Devise)
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    # Page and podcast metadata.
    config.name = 'brother.ly'
    config.description = "Philadelphia's electronic music showcase"
    config.keywords = %w[live electronic music philadelphia]

    # Hard-coded "founding year" of brother.ly, used in the copyright.
    config.founding_year = 2015

    # Whether the podcast is explicit or not.
    config.explicit = 'clean'

    # Capacity for when new events are created.
    config.capacity = 200

    # Seed tables in development.
    config.seeds = %w[artists episodes performances]

    # Add Refile helpers like +attachment_url+ and
    # +attachment_image_tag+ for rendering attachments in presenters.
    config.makeover.helpers << Refile::AttachmentHelper

    # Eventbrite defaults to using bogus gateway so real calls aren't
    # made in test or dev
    config.eventbrite_gateway = 'Eventbrite::BogusGateway'

    # Shorthand for finding DB name of current env
    config.db_name = config.database_configuration[Rails.env]['database']

    # Heroku production app name
    config.app_name = 'brotherly'
  end
end
