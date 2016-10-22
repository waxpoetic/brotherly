# frozen_string_literal: true
module Bitly
  class Service < Brotherly::Service
    remote ShortLink
    local :episode
    param :short_url

    after_create :update_episode

    def attributes
      { url: url }
    end

    private

    def update_episode
      episode.update short_url: remote.short_url
    end

    def url
      Rails.application.routes.url_helpers.episodes_path episode
    end
  end
end
