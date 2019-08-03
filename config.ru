# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

begin
  load File.expand_path('spring', __dir__)
rescue LoadError => e
  raise unless e.message.include?('spring')
end

require ::File.expand_path('../config/environment', __FILE__)

run Rails.application
