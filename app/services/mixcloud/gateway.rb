module Mixcloud
  class Gateway
    def initialize
      @host = URI.parse 'https://api.mixcloud.com'
      @port = 80
      @http = Net::HTTP.new @host, @port
    end

    def upload(params = {})
      req = Net::HTTP::Post::Multipart.new '/upload', params
      Response.new http.request(req)
    end
  end
end
