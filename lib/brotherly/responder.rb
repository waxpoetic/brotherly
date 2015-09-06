module Brotherly
  # Standard HTTP responses for the entire application.
  class Responder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder

    # Redirects resources to the collection path (index action) instead
    # of the resource path (show action) for POST/PUT/DELETE requests.
    # include Responders::CollectionResponder

    # Populate flash headers.
    def to_format
      flash.each do |type, message|
        controller.headers["X-Flash-#{type}"] = message
      end
      super
    end
  end
end
