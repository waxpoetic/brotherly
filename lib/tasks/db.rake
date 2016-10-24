# frozen_string_literal: true
namespace :db do
  desc 'Import database from db/import/production.dump'
  task import: :environment do
    database = Rails.configuration.database_configuration[Rails.env]['database']
    sh(
      'pg_restore',
      '--verbose',
      '--clean',
      '--no-acl',
      '--no-owner',
      "-d#{database}",
      'db/import/production.dump'
    )
  end
end
