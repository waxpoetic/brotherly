module Twitter
  class Gateway
    def initialize(secrets)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = secrets.twitter_consumer_key
        config.consumer_secret     = secrets.twitter_consumer_secret
        config.access_token        = secrets.twitter_access_token
        config.access_token_secret = secrets.twitter_access_secret
      end
    end

    def tweet(text)
      @client.update text
    end
  end
end
