begin
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  namespace :test do
    desc 'Run all tests'
    RSpec::Core::RakeTask.new :all

    desc 'Run unit tests'
    RSpec::Core::RakeTask.new :units do |t|
      t.pattern = 'spec/{controllers,decorators,helpers,jobs,lib,models,policies}/**/*_spec.rb'
    end

    desc 'Run feature tests'
    RSpec::Core::RakeTask.new :features do |t|
      t.pattern = 'spec/features/**/*_spec.rb'
    end

    desc 'Run all lint checks'
    RuboCop::RakeTask.new :lint
  end

  task test: %i(test:lint test:all)
end
