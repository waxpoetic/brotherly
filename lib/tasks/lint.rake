# frozen_string_literal: true

namespace :lint do
  begin
    require 'rubocop/rake_task'
    desc 'Run RuboCop lint checks'
    RuboCop::RakeTask.new :ruby
  rescue LoadError
    task :ruby do
      p 'RuboCop is not installed, Ruby lint checks will not run.'
    end
  end

  desc 'Run JavaScript and SCSS lint checks with Yarn'
  task :yarn do
    sh 'yarn run lint'
  end
end

desc 'Run code linters'
task lint: %w[lint:ruby lint:yarn]
