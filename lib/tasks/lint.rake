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
    system 'bin/scss-lint'
  end

  desc 'Run CoffeeScript lint checks'
  task :coffee do
    files = Dir['app/assets/javascripts/**/*.coffee'].join("\s")
    system "coffeelint #{files}"
  end
end

desc 'Run code linters'
task lint: %w(lint:ruby lint:scss lint:coffee)
