module Brotherly
  class Dotenv
    REJECTED_SETTINGS = /PORT|RAILS_ENV|PATH/

    attr_reader :path

    def initialize
      @path = File.join Rails.root, '.env'
    end

    def self.settings
      new.settings
    end

    def settings
      configuration.join "\s"
    end

    def configuration
      lines.select { |l| l =~ /=/ }.reject do |line|
        line =~ REJECTED_SETTINGS
      end
    end

    def lines
      config.split "\n"
    end

    def config
      File.read path
    end
  end
end
