require "brotherly/version"
require "active_support/dependencies/autoload"

module Brotherly
  extend ActiveSupport::Autoload

  autoload :Responder
  autoload :AdminResponder
  autoload :ExposureStrategy
  autoload :Worker
  autoload :Service
  autoload :ShortLink
  autoload :Transcoder
  autoload :Dotenv
  autoload :Decoratable

  def self.version
    VERSION
  end
end
