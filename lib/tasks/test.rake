# frozen_string_literal: true

begin
  require 'rspec/core/rake_task'

  NOT_FEATURES = Dir['spec/*'].reject do |dir|
    dir =~ /features|\./
  end.map do |dir|
    File.basename dir
  end.join(',')

  namespace :test do
    desc 'Run RSpec unit tests'
    RSpec::Core::RakeTask.new :unit do |t|
      t.pattern = "spec/{#{NOT_FEATURES}}/**/*_spec.rb"
    end

    desc 'Run RSpec feature tests'
    RSpec::Core::RakeTask.new :features do |t|
      t.pattern = 'spec/features/**/*_spec.rb'
    end
  end

  RSpec::Core::RakeTask.new :test
rescue LoadError
end
