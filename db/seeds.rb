require 'active_record/fixtures'

# Automatically loads data from the fixtures directory into the
# 'development' database. Allows for faster "spin-up" of the database.
# The seeds file can also be appended with some custom configuration,
# such as a default User. An example way of doing this has been
# commented out at the bottom of this file.
#
# It is recommended that fixtures are used to seed the database for both
# the 'development' and 'test' environments, or environments which take
# on characteristics of the aforementioned. This is so we can keep seed
# data in one place, and reduce the amount of duplication throughout the
# codebase.

Rails.application.config.active_record.seed_tables.each do |table|
  ActiveRecord::Fixtures.create_fixtures "spec/fixtures/#{table}.yml"
end

=begin
# In case you need to create objects manually, do it after fixtures are
# loaded in.
User.create \
  email: 'admin@example.com',
  password: 'admin123',
  password_confirmation: 'admin123'
  remember_me: true
=end
