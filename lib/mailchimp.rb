# Wraps +Gibbon+ to send subscribe requests over to Mailchimp.
module Mailchimp
  extend ActiveSupport::Autoload

  autoload :Gateway
  autoload :BogusGateway
  autoload :Subscriber

  def self.gateway_class
    if Rails.env =~ /development|test/
      BogusGateway
    else
      Gateway
    end
  end

  def self.gateway
    gateway_class.new(Rails.application.secrets)
  end
end
