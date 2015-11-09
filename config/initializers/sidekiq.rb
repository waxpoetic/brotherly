if defined? Sidekiq
  Sidekiq.configure_client do |config|
    config.redis = { size: 1 }
  end

  Sidekiq.configure_server do |config|
    database_url = ENV['DATABASE_URL']
    pool = ENV['MAX_THREADS'].to_i * 7

    if database_url
      ENV['DATABASE_URL'] = "#{database_url}?pool=#{pool}"
      ActiveRecord::Base.establish_connection
    end
  end
end
