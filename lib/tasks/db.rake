namespace :db do
  desc "Rebuild the multisearch index"
  task :index do
    %w(artist episode performance user).each do |model|
      Rake::Task['pg_search:multisearch:rebuild'].invoke model
    end
  end

  task setup: %w(db:index)
end
