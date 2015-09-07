require 'active_record/fixtures'

# Automatically load data from the fixtures directory into the
# 'development' database.
if Rails.env.development?
  ActiveRecord::Fixtures.create_fixtures(
    'spec/fixtures', Rails.application.config.seeds
  )
end

# Create an initial admin user.
User.create!(
  name: 'admin',
  email: Rails.application.secrets.admin_email,
  password: Rails.application.secrets.admin_password,
  password_confirmation: Rails.application.secrets.admin_password,
  remember_me: true
)
