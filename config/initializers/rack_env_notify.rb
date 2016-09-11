Rack::EnvNotify.notify = !Rails.env.production?
Rack::EnvNotify.message = "#{Rails.env} (#{SemVer.version})"
