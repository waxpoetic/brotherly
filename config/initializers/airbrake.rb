# frozen_string_literal: true

credentials = Rails.application.secrets.airbrake_project_id.present? &&
              Rails.application.secrets.airbrake_api_key.present?

if defined?(Airbrake) && credentials
  Airbrake.configure do |config|
    config.project_id = Rails.application.secrets.airbrake_project_id
    config.project_key = Rails.application.secrets.airbrake_api_key
  end
end
