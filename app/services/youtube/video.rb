module Youtube
  class Video
    attr_accessor :name
    attr_accessor :file
    attr_accessor :description
    attr_accessor :keywords

    validates :url, presence: true
    validates :title, presence: true
    validates :description, presence: true
    validates :keywords, presence: true

    def self.create(params = {})
      video = new params
      video.save
      video
    end

    def save
      valid? && create.success?
    end

    def persisted?
      @response.present?
    end

    def attributes
      {
        title: title,
        description: description,
        keywords: keywords
      }
    end

    def id
      return unless persisted?
      @id ||= @response.video_id
    end

    private

    def create
      @response ||= client.video_upload url, attributes
    end

    def client
      @client ||= YouTubeIt::OAuth2Client.new(
        client_access_token: "access_token",
        client_refresh_token: "refresh_token",
        client_id: "client_id",
        client_secret: "client_secret",
        dev_key: "dev_key",
        expires_at: "expiration time"
      )
    end
  end
end
