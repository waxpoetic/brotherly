module Application
  # Standard HTTP responses for the entire application.
  class Responder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder
  end
end
