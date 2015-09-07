WEB_CONCURRENCY = Integer(ENV['WEB_CONCURRENCY'] || 2)
MAX_THREADS = Integer(ENV['MAX_THREADS'] || 5)
MIN_THREADS = MAX_THREADS
PORT = ENV['PORT']
RACK_ENV = ENV['RAILS_ENV']

workers WEB_CONCURRENCY
threads MIN_THREADS, MAX_THREADS

preload_app!

rackup      DefaultRackup
port        PORT
environment RACK_ENV

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
