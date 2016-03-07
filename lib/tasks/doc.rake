begin
  require 'yard'

  YARD::Rake::YardocTask.new :doc

  namespace :doc do
    task :publish => [:doc] do
      sh 'mv doc /tmp/app-docs'
      sh 'git checkout gh-pages'
      sh 'mv /tmp/app-docs/**/* .'
      sh 'git add .'
      sh %(git commit -am "Update documentation for #{Brotherly.version}")
      sh 'git push'
    end
  end

rescue LoadError
end
