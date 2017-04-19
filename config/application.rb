# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails'

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

require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/redis_token_store'

require 'brotherly'

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
    config.description = "Philadelphia's monthly electronic music showcase"
    config.keywords = %w(live electronic music philadelphia)

    # Hard-coded "founding year" of brother.ly, used in the copyright.
    config.founding_year = 2015

    # Whether the podcast is explicit or not.
    config.explicit = 'clean'

    # Capacity for when new events are created.
    config.capacity = 200

    # Seed tables in development.
    config.seeds = %w(artists episodes performances events)

    # Configure CORS headers for font assets.
    config.font_assets.origin = '*'

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

    # Public identifier to the events calendar
    config.google_calendar_id = 'brotherlyparty@gmail.com'
    config.google_project_id = 'brotherly-161221'
  end
end
