module Brotherly
  class Client
    class Response
      class Error < StandardError
        def initialize(response)
          super "(#{response.status}) #{response} <#{response.type}>"
        end
      end
    end
  end
end
