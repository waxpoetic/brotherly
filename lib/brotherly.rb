require 'active_support/dependencies/autoload'

module Brotherly
  extend ActiveSupport::Autoload

  autoload :Service
  autoload :Dotenv
end
