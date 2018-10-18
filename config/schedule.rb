every 1.day, at: '4:30 am' do
  command "cd /srv/frontend/ && source /etc/mas/environment && RAILS_ENV=production bundle exec rake feed:store"
end
