module Application
  # Standard HTTP responses for the entire application.
  class Responder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder

    # Populate flash headers.
    def to_format
      set_flash_headers
      render_without_layout if controller.request.xhr?
      super
    end

    private

    def set_flash_headers
      flash.each do |type, message|
        controller.headers["X-Flash-#{type}"] = message
      end
    end

    def render_without_layout
      controller.layout = false
    end
  end
end