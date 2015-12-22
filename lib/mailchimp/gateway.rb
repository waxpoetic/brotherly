module Mailchimp
  class Gateway
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def create_member(params = {})
      list.members.create(body: params)
    end

    def list
      @list ||= mailchimp.lists(config.mailchimp_list_id)
    end

    def mailchimp
      @mailchimp ||= Gibbon::Request.new api_key: config.mailchimp_api_key
    end
  end
end
