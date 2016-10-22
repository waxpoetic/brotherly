# frozen_string_literal: true
module Mailchimp
  class BogusGateway < Gateway
    def create_member(params = {})
      Response.new request: params.merge('id' => SecureRandom.hex)
    end
  end
end
