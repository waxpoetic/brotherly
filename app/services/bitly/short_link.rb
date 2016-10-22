# frozen_string_literal: true
module Bitly
  class ShortLink
    include ActiveModel::Model

    attr_accessor :url
    attr_reader :link

    delegate :short_url, to: :link, allow_nil: true

    validates :url, presence: true

    def self.create(params = {})
      yield new(params).tap(&:save)
    end

    def save
      valid? && create && persisted?
    end

    def persisted?
      link.present?
    end

    def create
      @link = Bitly.client.shorten url, history: 1
    end
  end
end
