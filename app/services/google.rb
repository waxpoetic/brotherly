# Static configuration for the Google API.
module Google
  AUTH_URI = 'https://accounts.google.com/o/oauth2/auth'
  TOKEN_URI = 'https://accounts.google.com/o/oauth2/token'
  CERT_URL = 'https://www.googleapis.com/oauth2/v1/certs'
  REDIRECT_URL = 'http://www.brother.ly'
  JAVASCRIPT_ORIGIN_DOMAINS = %w(
    https://brother.ly
    http://brother.ly
    https://www.brother.ly
    http://www.brother.ly
    https://beta.brother.ly
    http://beta.brother.ly
  )
  USER_ID = 'default'
end
