require 'active_support/dependencies/autoload'

# Library code that supports the rest of the application, including
# custom base classes and other functionality.
module Brotherly
  extend ActiveSupport::Autoload

  autoload :Service

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
end
