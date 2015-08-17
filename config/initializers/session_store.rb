Rails.application.config.session_store :redis_store, \
  servers: {
     host: 'redis',
     port: 6379,
     db: 1,
     namespace: 'rails/session'
   },
   expires_in: 90.minutes
