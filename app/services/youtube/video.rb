module Youtube
  class Video
    attr_accessor :id
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
      valid? && create.present?
    end

    def destroy
      delete
    end

    def persisted?
      id.present?
    end

    def attributes
      {
        title: title,
        description: description,
        keywords: keywords
      }
    end

    private

    def create
      @id = client.upload self
    rescue
      nil
    end

    def delete
      client.destroy id
    rescue
      false
    end

    def gateway
      @gateway ||= Gateway.new Rails.application.secrets
    end
  end
end
