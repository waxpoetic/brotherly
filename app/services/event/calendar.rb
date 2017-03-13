# frozen_string_literal: true

class Event
  # Adapter for the Google Calendar v3.0 API service. Abstracts
  # authorization and record retrieval logic from the user and allows
  # the +Event::Collection+ to retrieve objects in a clean and concise
  # way.
  #
  # @see Event
  # @see Event::Collection
  class Calendar
    REDIRECT_URL = 'http://www.brother.ly'
    GOOGLE_AUTH_URI = 'https://accounts.google.com/o/oauth2/auth'
    GOOGLE_TOKEN_URI = 'https://accounts.google.com/o/oauth2/token'
    GOOGLE_CERT_URL = 'https://www.googleapis.com/oauth2/v1/certs'
    JAVASCRIPT_ORIGIN_DOMAINS = %w(
      https://brother.ly
      http://brother.ly
      https://www.brother.ly
      http://www.brother.ly
      https://beta.brother.ly
      http://beta.brother.ly
    )
    GOOGLE_USER_ID = 'default'
    GOOGLE_API_SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
    DEFAULT_MAX_RESULTS = 2500
    DEFAULT_ORDER_BY = 'startTime'

    def initialize(client_id: nil)
      @id = Rails.configuration.google_calendar_id
      @client_id = client_id
      @client_id_key = Brotherly.secrets.google_calendar_client_id
      @client_secret = Brotherly.secrets.google_calendar_client_secret
      @project_id = Rails.configuration.google_project_id
      @redis_url = "#{Brotherly.secrets.redis_url}/0/brotherly-google-token-store"
    end

    # Iterate over found events in the calendar.
    #
    # @return [Iterator]
    def each
      response.items.each { |item| yield item }
    end

    # The query used to search events in the Google Calendar API
    #
    # @return [Hash]
    def query
      @query ||= {
        single_events: true,
        order_by: DEFAULT_ORDER_ATTRIBUTE,
        max_results: DEFAULT_MAX_RESULTS,
        time_min: Time.current.iso8601
      }
    end

    # Test if credentials can be fetched from the local store.
    #
    # @return [Boolean] whether +credentials+ are present.
    def authorized?
      credentials.present?
    end

    # Google-hosted URL that authorizes this application to read the
    # Google Calendar for +brotherlyparty@gmail.com+.
    #
    # @return [String] Google OAuth 2 URL
    def authorize_url
      authorizer.get_authorization_url base_url: REDIRECT_URL
    end

    # Retrieve credentials and store them in the local +token_store+ by
    # supplying the validation key.
    #
    # @param code [String] Authorization code for this request.
    # @return [Hash] +credentials+ that have been stored.
    def login(code)
      authorizer.get_and_store_credentials_from_code(
        user_id: GOOGLE_USER_ID,
        code: code,
        base_url: REDIRECT_URL
      )
      credentials
    end

    private

    # @private
    # @return [Google::Auth::UserAuthorizer]
    def authorizer
      Google::Auth::UserAuthorizer.new(
        client_id, GOOGLE_API_SCOPE, token_store
      )
    end

    # Raw HTTP response data from search query.
    #
    # @private
    # @return [Google::Api::Response]
    def response
      service.list_events(query)
    end

    # The Google Calendar service object used to communicate with the
    # API.
    #
    # @private
    # @return [Google::Apis::CalendarV3::CalendarService]
    def service
      @service ||= Google::Apis::CalendarV3::CalendarService.new.tap do |service|
        service.client_options.application_name = Rails.configuration.app_name
        service.authorization = credentials
      end
    end

    # Authorization credentials from the authorizer for the pre-defined
    # user ID.
    #
    # @private
    # @return [Google::Auth::Credentials]
    def credentials
      @credentials ||= authorizer.get_credentials GOOGLE_USER_ID
    end

    # Build a client ID authorization object from the derived
    # configuration Hash.
    #
    # @private
    # @return [Google::Auth::ClientId]
    def client_id
      @client_id ||= Google::Auth::ClientId.from_hash config
    end

    # Configuration for the +Google::Auth::ClientId+ object, meant to
    # look exactly like the JSON structure that can be downloaded from
    # the Google developer API. Unfortunately, we can't store this on
    # Heroku without breaking security protocol, so we must represent it
    # in a Hash format here.
    #
    # @private
    # @return [Hash].
    def config
      @config ||= {
        web: {
          client_id: @client_id_key,
          project_id: @project_id,
          auth_uri: GOOGLE_AUTH_URI,
          token_uri: GOOGLE_TOKEN_URI,
          auth_provider_x509_cert_url: GOOGLE_CERT_URL,
          client_secret: @client_secret,
          redirect_urls: [REDIRECT_URL],
          javascript_origins: JAVASCRIPT_ORIGIN_DOMAINS
        }
      }.deep_stringify_keys
    end

    # OAuth token storage in Redis.
    #
    # @private
    # @return [Google::Auth::Stores::RedisTokenStore]
    def token_store
      @token_store ||= Google::Auth::Stores::RedisTokenStore.new(
        url: "#{Brotherly.secrets.redis_url}/0",
        prefix: 'brotherly_google_user_token:'
      )
    end
  end
end
