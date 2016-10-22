# frozen_string_literal: true
DEFAULT_LEVEL = 'patch'

namespace :release do
  task :bump, [:level] do |_, arguments|
    level = arguments[:level] || DEFAULT_LEVEL
    system "bin/semver increment #{level}"
  end

  task :commit do
    system 'git commit -am "$(bin/semver tag)"'
  end

  task :tag do
    system 'git tag -a "$(bin/semver tag)" -m "$(bin/semver tag)"'
  end

  task :push do
    system 'git push origin master && git push origin --tags'
  end

  [:major, :minor, :patch, :special].each do |level|
    desc "Deploy and release a new #{level} version"
    task level do
      Rake::Task[:release].invoke level
    end
  end
end

desc "Deploy and release a new version (default level: #{DEFAULT_LEVEL})"
task :release, [:level] => %w(
  release:bump release:commit release:tag release:push
)
