module Mixcloud
  class Response
    def initialize(http)
      @http = http
    end

    def success?
      @http.is_a? Net::HTTPSuccess
    end
  end
end
