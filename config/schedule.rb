every 1.day, at: '4:30 am' do
  job_type :rake, "cd /srv/frontend/ && source /etc/mas/environment && RAILS_ENV=production bundle exec rake :task --silent :output"

  rake 'feed:store' # from the PACs engine
end
