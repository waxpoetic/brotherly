require 'active_record/fixtures'

puts "-- seed '#{Rails.env}'"

#if Rails.env.development?
  puts "   add fixtures"
  ActiveRecord::Fixtures.create_fixtures(
    'spec/fixtures', Rails.application.config.seeds
  )
#end

unless User.where(name: 'admin').any?
  puts "   add initial admin user"
  User.create!(
    name: 'admin',
    email: Rails.application.secrets.admin_email,
    password: Rails.application.secrets.admin_password,
    password_confirmation: Rails.application.secrets.admin_password,
    remember_me: true
  )
end

puts "   -> done"
