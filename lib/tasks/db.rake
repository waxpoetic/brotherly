# frozen_string_literal: true
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
end
