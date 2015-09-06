if Rails.env =~ /development|test/
  Rails.application.config.session_store :cookie_store, key: '_brotherly_session'
else
  Rails.application.config.session_store :redis_store, \
    servers: {
       host: 'redis',
       port: 6379,
       db: 0,
       namespace: 'brotherly-session'
     },
     expires_in: 90.minutes
end
