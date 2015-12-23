module Mailchimp
  class BogusGateway < Gateway
    def create_member(_params = {})
      Response.new request: _params.merge('id' => SecureRandom.hex)
    end
  end
end
