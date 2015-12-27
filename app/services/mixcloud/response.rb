require 'net/http'
require 'json'

module Mixcloud
  class Response
    delegate :[], to: :body

    def initialize(http)
      @http = http
    end

    def success?
      @http.is_a? Net::HTTPSuccess
    end

    def body
      @body ||= JSON.parse @http.body
    rescue JSON::ParserError => exception
      Rails.logger.error exception.message
      {}
    end
  end
end
