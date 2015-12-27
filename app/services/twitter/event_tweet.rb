module Twitter
  class EventTweet
    include ActiveModel::Model

    attr_accessor :text

    validates :text, presence: true

    def save
      valid? && create.success?
    end

    def create
      @response = gateway.tweet text
    end

    def gateway
      @gateway ||= Gateway.new
    end
  end
end
