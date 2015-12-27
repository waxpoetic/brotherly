module Mixcloud
  class Upload
    class Request < Net::HTTP::Post::Multipart
      def initialize(params, token)
        @params = params
        @token = token
        super '/upload', params.merge(access_token: @token)
      end
    end
  end
end
