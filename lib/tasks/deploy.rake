desc 'Tasks to run on the server after we deploy.'
task deploy: %w(db:migrate db:index tmp:create sitemap:refresh)
