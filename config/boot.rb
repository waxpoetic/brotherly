ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

$LOAD_PATH << File.expand_path('../lib', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
