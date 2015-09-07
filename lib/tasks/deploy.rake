namespace :deploy do
  task :app do
    sh 'git push heroku master'
  end

  task config: :environment do
    sh "heroku config:set #{Brotherly::Dotenv.settings}"
  end
end

desc "Deploy this app and secure .env config to Heroku"
task deploy: %w(deploy:app deploy:config)
