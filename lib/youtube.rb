require 'active_support/dependencies/autoload'
require 'youtube_it'

module Youtube
  extend ActiveSupport::Autoload

  autoload :Video
end
