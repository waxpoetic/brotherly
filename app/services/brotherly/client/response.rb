module Brotherly
  class Client
    # Wraps a +Net::HTTPResponse+ object so it's easier to work with in
    # the client. Provides a consistent interface for the
    # +Brotherly::Client+.
    class Response
      # @!attribute [r] status
      #   @return [Integer] Status code of the HTTP response.
      attr_reader :status

      # @!attribute [r] headers
      #   @return [Hash] HTTP headers associated with the response.
      attr_reader :headers

      attr_reader :type

      # @param [Net::HTTPResponse] Response object responding to
      # `#code`, `#status`, `#headers` and `#body`.
      def initialize(response)
        @type = response.class.name
        @status = response.code.to_i
        @body = response.body
        @headers = response.headers

        raise Error, self unless success?
      end

      # Test if the request was successful.
      #
      # @return [Boolean] whether the response status is between 200 and 299
      def success?
        status =~ 200..299
      end

      # Parse out the response body as JSON.
      #
      # @return [Array<Hash>] collection of data from the API.
      def body
        JSON.parse to_s
      end

      def to_str
        @body ||= 'Empty Response'
      end

      def to_hash
        body
      end
    end
  end
end
