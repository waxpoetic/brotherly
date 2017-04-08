# frozen_string_literal: true

require 'net/http'
require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/redis_token_store'

# Library code that supports the rest of the application, including
# custom base classes and other functionality.
module Brotherly
  PRODUCTION_DOMAIN_NAME = 'brother.ly'
  STAGING_DOMAIN_NAME = 'beta.brother.ly'

  # Return the version of this application.
  #
  # @return [SemVer]
  def self.version
    @version ||= SemVer.find
  end

  # Shortcut to secrets accessor.
  #
  # @return [ActiveSupport::OrderedOptions]
  def self.secrets
    Rails.application.secrets
  end

  # Current "stage" name based on the domain name. Tells the admin what
  # environment we're in. If the domain name doesn't match
  # pre-configured staging or production, return the domain name with
  # ".brother.ly" removed (e.g. "alpha.brother.ly" => "alpha")
  #
  # @return [String]
  def self.stage
    return Rails.env unless Rails.env.production?
    case secrets.domain_name
    when STAGING_DOMAIN_NAME
      'staging'
    when PRODUCTION_DOMAIN_NAME
      'production'
    else
      secrets.domain_name&.gsub(/\.brother\.ly\Z/, '')
    end
  end
end
