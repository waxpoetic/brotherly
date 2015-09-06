module Brotherly
  class ShortLink
    include ActiveModel::Model

    attr_reader :url

    def url
      link.short_url
    end

    private

    def link
      @link ||= Bitly.client.shorten url, history: 1
    end
  end
end
