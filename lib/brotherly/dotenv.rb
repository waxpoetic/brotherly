module Brotherly
  class Dotenv
    REJECTED_SETTINGS = %w(PORT RAILS_ENV)

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
      lines.reject do |line|
        REJECTED_SETTINGS.include? line
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
