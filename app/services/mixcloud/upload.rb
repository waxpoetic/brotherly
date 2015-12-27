module Mixcloud
  class Upload
    attr_accessor :mp3
    attr_accessor :name
    attr_accessor :picture
    attr_accessor :description

    def self.create(params = {})
      upload = new params
      upload.save
      upload
    end

    def attributes
      {
        mp3: mp3,
        name: name,
        picture: picture,
        description: description
      }
    end

    def save
      valid? && create.success?
    end

    def persisted?
      @response && @response.success?
    end

    def mp3
      UploadIO.new @mp3, 'audio/mp3', "#{name}.mp3"
    end

    def picture
      UploadIO.new @picture, 'image/png', "#{name}.png"
    end

    private

    def create
      @response = gateway.upload attributes
    end

    def gateway
      @gateway ||= Gateway.new
    end
  end
end
