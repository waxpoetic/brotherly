# frozen_string_literal: true

# Library code that supports the rest of the application, including
# custom base classes and other functionality.
module Brotherly
  # Return the version of this application.
  #
  # @return [SemVer]
  def self.version
    @version ||= SemVer.find
  end

  def self.secrets
    Rails.application.secrets
  end

  def self.stage
    case Rails.configuration.domain
    when /beta/
      'staging'
    when /\.dev/
      'development'
    end
  end

  def basic_auth?
    secrets.http_basic_username && secrets.http_basic_password
  end
end
