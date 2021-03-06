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
    case secrets.domain_name
    when 'beta.brother.ly'
      'staging'
    when 'brother.ly'
      'production'
    else
      'development'
    end
  end
end
