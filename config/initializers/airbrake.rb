if defined? Airbrake
  Airbrake.api_key = Rails.application.secrets.airbrake_api_key
end
