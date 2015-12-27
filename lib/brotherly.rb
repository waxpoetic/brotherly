require 'active_support/dependencies/autoload'

# Library code that supports the rest of the application, including
# custom base classes and other functionality.
module Brotherly
  extend ActiveSupport::Autoload

  autoload :Service
  autoload :Listener

  # Return the version of this application.
  #
  # @return [SemVer]
  def self.version
    @version ||= SemVer.find
  end
end
