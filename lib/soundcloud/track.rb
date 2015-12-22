module SoundCloud
  class Track
    include ActiveModel::Model

    attr_accessor :title, :asset_data

    validates :title,       presence: true
    validates :asset_data,  presence: true

    def self.create(params = {})
      track = new(params)
      track.save
      track
    end

    def save
      valid? && create && persisted?
    end

    def persisted?
      @track.present?
    end

    def attributes
      {
        title: title,
        asset_data: asset_data
      }
    end

    private

    def create
      @track = client.post '/tracks', track: attributes
    rescue
      false
    end

    def client
      @client ||= SoundCloud.new(
        client_id: config.soundcloud_client_id,
        client_secret: config.soundcloud_client_secret,
        refresh_token: config.soundcloud_refresh_token
      )
    end

    def config
      Rails.application.secrets
    end
  end
end
