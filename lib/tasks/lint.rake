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

  desc 'Run SCSS lint checks'
  task :scss do
    require 'scss_lint'
    require 'scss_lint/cli'
    logger = SCSSLint::Logger.new(STDOUT)
    puts 'Running SCSSLint...'
    code = SCSSLint::CLI.new(logger).run %w(
      app/assets/stylesheets
      --format=TAP
    )
    exit code if code.positive?
  end

  desc 'Run CoffeeScript lint checks'
  task :coffee do
    files = Dir['app/assets/javascripts/**/*.coffee'].join("\s")
    puts 'Running CoffeeLint...'
    system "coffeelint #{files}"
    exit 1 unless $CHILD_STATUS.success?
  end
end

desc 'Run code linters'
task lint: %w(lint:ruby lint:scss lint:coffee)
