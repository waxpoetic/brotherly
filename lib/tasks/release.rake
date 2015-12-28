namespace :release do
  task :bump, [:level] do |_, arguments|
    level = arguments[:level] || 'patch'
    system "bin/semver increment #{level}"
  end

  task commit: :environment do
    system "git commit -am '#{Brotherly.version}'"
  end

  task :tag do
    system "git tag #{Brotherly.version} -m '#{Brotherly.version}'"
  end

  task :push do
    system 'git push origin master && git push origin --tags'
  end

  [:major, :minor, :patch, :special].each do |level|
    desc "Deploy and release a new #{level} version to brother.ly"
    task level do
      Rake::Task[:release].invoke level
    end
  end
end

# Deploy and release a new version of this application
task :release, [:level] => [
  'release:bump', 'release:commit', 'release:tag', 'release:push'
]
