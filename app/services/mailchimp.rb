# Wraps +Gibbon+ to send subscribe requests over to Mailchimp.
module Mailchimp
  def self.gateway_class
    if Rails.env =~ /development|test/
      BogusGateway
    else
      Gateway
    end
  end

  def self.gateway
    gateway_class.new
  end
end
