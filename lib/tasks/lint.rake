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

  begin
    require 'scss_lint/rake_task'
    SCSSLint::RakeTask.new :scss do |t|
      t.files = FileList.new('app/assets/stylesheets/**/*.scss')
    end
  rescue LoadError
    task :scss do
      p 'scss-lint is not installed. scss lint checks will not run.'
    end
  end

  desc 'Run JavaScript lint checks'
  task :js do
    sh 'jshint app/assets/javascripts/*.js'
  end
end

desc 'Run code linters'
task lint: %w(lint:ruby lint:scss lint:js)
