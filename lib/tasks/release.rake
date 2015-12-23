namespace :release do
  task :bump, [:type] do |task, type|
    system "bin/semver increment #{type}"
  end

  task :tag do
    system 'git tag $(bin/semver tag)'
  end

  task :push do
    system 'git push origin master'
  end
end

desc 'Deploy and release a new version of this application'
task :release, [:type] => ['release:bump', 'release:tag', 'release:push']
