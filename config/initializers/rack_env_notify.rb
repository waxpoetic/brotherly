# frozen_string_literal: true
Rack::EnvNotifier.notify = !Rails.env.production?
Rack::EnvNotifier.message = "#{Rails.env} (#{SemVer.find})"
