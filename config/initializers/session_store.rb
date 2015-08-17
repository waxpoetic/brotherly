Rails.application.config.session_store :redis_store, \
  servers: {
     host: 'redis',
     port: 6379,
     db: 0,
     namespace: 'session'
   },
   expires_in: 90.minutes
