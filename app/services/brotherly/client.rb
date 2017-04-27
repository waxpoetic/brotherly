module Brotherly
  # HTTP client for communicating with the brother.ly API. Since
  # brother.ly is a public, read-only API, we only provide a `#get`
  # method to retrieve data from the server.
  class Client
    # Use the JSON Content-Type for all HTTP requests.
    MIME_TYPE = 'application/json'

    # Ensure we get UTF-8 encoded data from the API.
    ENCODING = 'utf-8'

    # @param host [String] Domain name to connect to.
    # @param port [Integer] Port to connect with.
    def initialize(host: , port: 80)
      @http = Net::HTTP.new host, port
      @headers = {
        'Accept' => "#{MIME_TYPE};charset=#{ENCODING}"
      }
    end

    def self.connect(host)
      new host: host
    end

    # Perform an HTTP GET request at the specified path.
    #
    # @param path [String] Path name of the request
    # @return [Brotherly::Client::Response] HTTP response from the API.
    def get(path)
      Response.new @http.get(path, @headers)
    end
  end
end
