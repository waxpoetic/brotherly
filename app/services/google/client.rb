module Google
  # Actual HTTP client for the Google v3 APIs.
  class Client
    # @!attribute config [r]
    #   @return [Hash] Configuration for the +Google::Auth::ClientId+ object, meant to
    #                  look exactly like the JSON structure that can be downloaded from
    #                  the Google developer API. Unfortunately, we can't store this on
    #                  Heroku without breaking security protocol, so we must represent it
    #                  in a Hash format here.
    attr_reader :config

    # @!attribute scope [r]
    #   @return [String] API permission scope for this client session
    attr_reader :scope

    # @!attribute redis_url [r]w
    #   @return [String] Fully-qualified Redis URL for storing Google API tokens
    attr_reader :redis_url

    # @param scope [String] API scope for this client session
    def initialize(scope = Google::Calendar::API_SCOPE)
      @scope = scope
      @redis_url = "#{Brotherly.secrets.redis_url}/0/brotherly-google-token-store"
      @config ||= {
        web: {
          client_id: Brotherly.secrets.google_calendar_client_id,
          project_id: Rails.configuration.google_project_id,
          auth_uri: Google::AUTH_URI,
          token_uri: Google::TOKEN_URI,
          auth_provider_x509_cert_url: Google::CERT_URL,
          client_secret: Brotherly.secrets.google_calendar_client_secret,
          redirect_urls: [Google::REDIRECT_URL],
          javascript_origins: Google::ORIGINS
        }
      }.deep_stringify_keys
    end

    # Test if credentials can be fetched from the local store.
    #
    # @return [Boolean] whether +credentials+ are present.
    def authorized?
      credentials.present?
    end

    # Retrieve credentials and store them in the local +token_store+ by
    # supplying the validation key.
    #
    # @param code [String] Authorization code for this request.
    # @return [Hash] +credentials+ that have been stored.
    def login(code)
      authorizer.get_and_store_credentials_from_code(
        user_id: Google::USER_ID,
        code: code,
        base_url: Google::REDIRECT_URL
      )
      credentials
    end

    # Google-hosted URL that authorizes this application to read the
    # Google Calendar for +brotherlyparty@gmail.com+.
    #
    # @return [String] Google OAuth 2 URL
    def authorize_url
      authorizer.get_authorization_url base_url: Google::REDIRECT_URL
    end

    # Perform API calls using a given service class from the
    # +Google::Apis+ namespace. It will be authenticated properly in the
    # block, and return whatever the block returns.
    #
    # @param service_class [Class] Service object class name to use
    # @return whatever the block returns
    # @yield [service_object]
    def with(service_class)
      service = service_class.new
      service.client_options.application_name = Rails.configuration.app_name
      service.authorization = credentials
      yield service
    end

    private

    # Authorization credentials from the authorizer for the pre-defined
    # user ID.
    #
    # @private
    # @return [Google::Auth::Credentials]
    def credentials
      @credentials ||= authorizer.get_credentials Google::USER_ID
    end

    # Build a client ID authorization object from the derived
    # configuration Hash.
    #
    # @private
    # @return [Google::Auth::ClientId]
    def client_id
      @client_id ||= Auth::ClientId.from_hash config
    end

    # OAuth token storage in Redis.
    #
    # @private
    # @return [Google::Auth::Stores::RedisTokenStore]
    def token_store
      @token_store ||= Auth::Stores::RedisTokenStore.new(
        url: redis_url,
        prefix: 'brotherly_google_user_token:'
      )
    end

    # User authorizer object for Google.
    #
    # @private
    # @return [Google::Auth::UserAuthorizer]
    def authorizer
      Auth::UserAuthorizer.new(
        client_id, scope, token_store
      )
    end
  end
end
