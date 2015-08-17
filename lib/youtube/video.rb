require 'youtube_it'

module Youtube
  class Video
    def initialize(params = {})
      @attributes = params
    end

    def self.create(params = {})
      video = new(params)
      video.save
      video
    end

    def save
      client.upload_token(attributes, next_url)
    end

    private

    def next_url
      'http://example.com'
    end

    def client
      @client ||= YouTubeIt::Client.new(
        username: Rails.application.secrets.youtube_username,
        password: Rails.application.secrets.youtube_password,
        dev_key: Rails.application.secrets.youtube_dev_key
      )
    end
  end
end
