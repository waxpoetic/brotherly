module Mailchimp
  class Gateway
    def create_member(params = {})
      list.members.create(body: params)
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
