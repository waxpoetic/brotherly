module Brotherly
  class ShortLink
    include ActiveModel::Model

    attr_accessor :url

    delegate :short_url, to: :@link

    validates :url, presence: true
    validates :short_url, presence: true

    def self.create(params = {})
      link = new(params)
      link.valid?
      link
    end

    def save
      @link = create
    end

    def persisted?
      @link.present?
    end

    def create
      Bitly.client.shorten url, history: 1
    end
  end
end
