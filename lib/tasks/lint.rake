begin
  require 'rubocop/rake_task'

  desc 'Run RuboCop lint checks'
  RuboCop::RakeTask.new :lint
rescue LoadError
end
