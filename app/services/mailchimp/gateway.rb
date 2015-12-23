module Mailchimp
  # A wrapper for Gibbon that acts as our gateway to the Mailchimp
  # service. Although Gibbon actually performs the HTTP requests related
  # to Mailchimp, this class is responsible for putting them together
  # and then returning responses in a consistent manner.
  class Gateway
    def self.class_for_env
      if Rails.env =~ /development|test/
        BogusGateway
      else
        Gateway
      end
    end

    def self.for_env
      @for_env ||= class_for_env.new
    end

    def create_member(params = {})
      Response.new request: list.members.create(body: params)
    end

    def list
      @list ||= gibbon.lists(config.mailchimp_list_id)
    end

    private

    def gibbon
      @gibbon ||= Gibbon::Request.new api_key: config.mailchimp_api_key
    end

    def config
      Rails.application.secrets
    end
  end
end
