namespace :release do
  task :bump, [:type] do |_, arguments|
    system "bin/semver increment #{arguments[:type]}"
  end

  task :tag do
    system 'git tag $(bin/semver tag)'
  end

  task :push do
    system 'git push && git push --tags'
  end
end

desc 'Deploy and release a new version of this application'
task :release, [:type] => ['release:bump', 'release:tag', 'release:push']
