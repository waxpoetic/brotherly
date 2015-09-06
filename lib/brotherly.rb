require "brotherly/version"
require "active_support/dependencies/autoload"

module Brotherly
  extend ActiveSupport::Autoload

  autoload :Worker
  autoload :Service
  autoload :ShortLink

  def self.version
    VERSION
  end
end
