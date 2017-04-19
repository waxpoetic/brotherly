# frozen_string_literal: true
if defined? Sidekiq
  Sidekiq.configure_client do |config|
    config.redis = { size: 1 }
  end

  schedule_file = Rails.root.join 'config', 'schedule.yml'

  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end
