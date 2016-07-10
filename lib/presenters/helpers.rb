module Presenters
  class Helpers
    include ActionView::Helpers
    include Refile::AttachmentHelper

    def initialize
      @routes = Rails.application.routes.url_helpers
    end

    def method_missing(method, *arguments)
      return super unless respond_to? method
      @routes.send method, *arguments
    end

    def respond_to?(method, *_)
      @routes.respond_to?(method) || super
    end
  end
end
