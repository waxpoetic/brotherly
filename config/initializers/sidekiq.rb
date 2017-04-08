# frozen_string_literal: true
if defined? Sidekiq
  Sidekiq.configure_client do |config|
    config.redis = { size: 1 }
  end

  if Brotherly.stage == 'staging'
    Sidekiq::Cron::Job.create(
      name: 'Copy production data at 9am every day',
      cron: '0 9 * * *',
      class: 'CopyProductionDataJob',
      active_job: true
    )
  end
end
