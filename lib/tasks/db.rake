# frozen_string_literal: true

namespace :db do
  desc 'Pull down production data to the current environment'
  task pull: %w(environment db:pull:images) do
    config = Rails.configuration
    sh "dropdb #{config.db_name}"
    sh "heroku pg:pull DATABASE_URL #{config.db_name} --app #{config.app_name}"
  end

  namespace :pull do
    task images: :environment do
      sh "aws s3 sync s3://files.brother.ly/store #{Refile.store.directory}"
    end
  end

  desc 'Push current database to the production environment'
  task push: :environment do
    sh "heroku pg:push #{config.db_name} DATABASE_URL --app #{config.app_name}"
  end

  namespace :staging do
    desc 'Push current database to the staging environment'
    task push: :environment do
      staging = "#{config.app_name}-staging"
      sh "heroku pg:push #{config.db_name} DATABASE_URL --app #{staging}"
    end
  end
end
