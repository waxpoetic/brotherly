module Mailchimp
  class BogusGateway < Gateway
    def create_member(_params = {})
      true
    end
  end
end
