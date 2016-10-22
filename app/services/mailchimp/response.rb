# frozen_string_literal: true
module Mailchimp
  # Common response object to both the gateway and bogus gateway.
  class Response
    # @param [Gibbon::APIRequest] request
    def initialize(request: {})
      @request = request
    end

    def [](key)
      @request[key]
    end

    def success?
      self['id'].present?
    end

    def method_missing(method, *arguments)
      return super unless respond_to? method
      self[method.to_s]
    end

    def respond_to?(method)
      @request.keys.include?(method.to_s) || super
    end
  end
end
