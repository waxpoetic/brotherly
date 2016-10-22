# frozen_string_literal: true
if defined? Airbrake
  Airbrake.configure do |config|
    config.project_id = Rails.application.secrets.airbrake_project_id
    config.project_key = Rails.application.secrets.airbrake_api_key
  end
end
