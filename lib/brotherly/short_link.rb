module Brotherly
  class ShortLink
    include ActiveModel::Model

    attr_accessor :url

    delegate :short_url, to: :link

    validates :url, presence: true
    validates :link, presence: true
    validates :short_url, presence: true

    def self.create(params = {})
      link = new(params)
      link.valid?
      link
    end

    private

    def link
      @link ||= Bitly.client.shorten url, history: 1
    end
  end
end
