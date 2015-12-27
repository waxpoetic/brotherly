module Youtube
  class Gateway
    def initialize(config)
      @client = YouTubeIt::OAuth2Client.new(
        client_access_token: config.youtube_client_access_token,
        client_refresh_token: config.youtube_client_refresh_token,
        client_id: config.youtube_client_id,
        client_secret: config.youtube_client_secret,
        dev_key: config.youtube_dev_key,
        expires_at: config.youtube_expiration_time
      )
    end

    def upload(video)
      @client.video_upload(video.url, video.attributes).first.video_id
    end

    def destroy(id)
      @client.video_destroy(id)
    end
  end
end
