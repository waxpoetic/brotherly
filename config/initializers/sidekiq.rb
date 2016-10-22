# frozen_string_literal: true
if defined? Sidekiq
  Sidekiq.configure_client do |config|
    config.redis = { size: 1 }
  end
end
