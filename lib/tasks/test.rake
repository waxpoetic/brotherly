begin
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  NOT_FEATURES = Dir['spec/*'].reject do |dir|
    dir =~ /features/
  end.map do |dir|
    File.basename dir
  end.join(',')

  namespace :test do
    RSpec::Core::RakeTask.new :all

    desc 'Run RSpec unit tests'
    RSpec::Core::RakeTask.new :unit do |t|
      t.pattern = "spec/{#{NOT_FEATURES}}/**/*_spec.rb"
    end

    desc 'Run RSpec feature tests'
    RSpec::Core::RakeTask.new :features do |t|
      t.pattern = 'spec/features/**/*_spec.rb'
    end

    desc 'Run RuboCop lint checks'
    RuboCop::RakeTask.new :lint
  end

  desc 'Run all RuboCop lint checks and RSpec code examples'
  task test: %i(test:lint test:unit test:features)
rescue LoadError
  # ignore
end
