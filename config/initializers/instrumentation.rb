ActiveSupport::Notifications.subscribe('request.faraday') do |name, starts, ends, _, env|
  url         = env[:url]
  http_method = env[:method].to_s.upcase
  duration    = ends - starts

  Rails.logger.info '[%s] %s %s (%.3f s)' % [url.host, http_method, url.request_uri, duration]
end

statsd = Statsd.new(ENV['STATSD_HOST'], ENV['STATSD_PORT']).tap do |client|
  client.namespace = 'frontend'
end

Nunes.subscribe(statsd)
