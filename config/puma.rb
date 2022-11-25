rackup      DefaultRackup if defined?(DefaultRackup)
environment ENV.fetch('RACK_ENV', 'development')
workers     ENV.fetch('WEB_CONCURRENCY', 1)
threads     ENV.fetch('RAILS_MAX_THREADS', 5), ENV.fetch('RAILS_MAX_THREADS', 5)
port        ENV.fetch('PORT', 3000)

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
