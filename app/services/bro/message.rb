module Bro
  # Send a message to the Campfire room via the @bro chatbot.
  class Message
    HOST = 'bro.herokuapps.com'
    PORT = 80

    attr_reader :http, :text

    def initialize(text: '')
      @text = text
      @http = Net::HTTP.new HOST, PORT
    end

    def self.create(text)
      new(text: text).tap(&:save)
    end

    def valid?
      @text.present?
    end

    def save
      valid? && create && persisted?
    end

    def persisted?
      @response.is_a? Net::HTTPSuccess
    end

    private

    def create
      @response = http.post PATH, text
    end
  end
end
