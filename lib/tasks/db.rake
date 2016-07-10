namespace :db do
  desc 'Rebuild the multisearch index'
  task :index do
    puts '-- rebuild postgresql multisearch index'
    %w(artist episode performance user).each do |model|
      puts "   index #{model.pluralize}"
      Rake::Task['pg_search:multisearch:rebuild'].invoke model
    end
    puts '   -> done'
  end

  task :setup do
    Rake::Task['db:index'].invoke
  end

  task :reset do
    Rake::Task['db:seed'].invoke
    Rake::Task['db:index'].invoke
  end

  def import_database(app, to: '')
    db = Rails.configuration.database_configuration[Rails.env].with_indifferent_access
    unless File.exist? Rails.root.join(to).to_s
      sh "heroku pg:backups capture --app=#{app}"
      sh "curl -o #{to} `heroku pg:backups public-url --app=#{app}`"
    end
    sh [
      'pg_restore',
      '--verbose --clean --no-acl --no-owner',
      "-d #{db[:database]}",
      to
    ].join("\s")
  end

  namespace :import do
    desc 'Pull production data into the local database'
    task production: :environment do
      import_database 'brotherly', to: 'db/import/production.dump'
    end

    desc 'Pull staging data into the local database'
    task staging: :environment do
      import_database 'brotherly-staging', to: 'db/import/staging.dump'
    end
  end
end
