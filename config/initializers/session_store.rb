if Rails.env =~ /development|test/
  Rails.application.config.session_store :cookie_store, key: '_brotherly_session'
else
  Rails.application.config.session_store :redis_store, \
                                         servers: "#{Rails.application.secrets.redis_url}/0/brotherly-session"
end
