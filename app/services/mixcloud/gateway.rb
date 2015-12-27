require 'net/http'

module Mixcloud
  class Gateway
    def initialize
      @host = URI.parse 'https://api.mixcloud.com'
      @port = 80
      @http = Net::HTTP.new @host, @port
      @access_token = Rails.application.secrets.mixcloud_access_token
    end

    def upload(params = {})
      Response.new http.request(Upload::Request.new params, @access_token)
    end
  end
end
