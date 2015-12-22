namespace :deploy do
  task :app do
    sh 'git push heroku master'
  end

  desc 'Update Heroku configuration from .env settings'
  task config: :environment do
    sh "heroku config:set #{Brotherly::Dotenv.settings}"
  end
end

desc 'Deploy this app to Heroku'
task deploy: %w(deploy:app)
