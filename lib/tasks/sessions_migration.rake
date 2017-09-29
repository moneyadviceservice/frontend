namespace :redis do
  namespace :sessions do
    desc 'Migrate Active record session store to redis'
    task migrate: :environment do
      redis_url = ENV.fetch('REDIS_SESSIONS_URL')
      redis = Redis.new(url: redis_url)
      sessions = ActiveRecord::Base.connection.select_all('select * from sessions')
      sessions.each do |session|
        data = ActiveRecord::SessionStore::Session.deserialize(session['data'])

        redis.setex(
          session['session_id'],
          1.month.to_i,
          Marshal.dump(data).to_s.force_encoding(Encoding::BINARY)
        )
      end
    end
  end
end
