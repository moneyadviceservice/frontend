ActiveSupport::Notifications.subscribe('request.faraday') do |name, starts, ends, _, env|
  url         = env[:url]
  http_method = env[:method].to_s.upcase
  duration    = ends - starts

  Rails.logger.info '[%s] %s %s (%.3f s)' % [url.host, http_method, url.request_uri, duration]
end

statsd = Statsd.new(ENV['STATSD_HOST'], ENV['STATSD_PORT']).tap { |client| client.namespace = 'frontend' }

ActiveSupport::Notifications.subscribe('request.content-service.search') do |_, starts, ends, _, options|
  key = "search.content_service.#{options[:locale]}"

  statsd.increment(key)
  statsd.timing(key, (ends - starts))
end

ActiveSupport::Notifications.subscribe('request.google_api.search') do |_, starts, ends, _, options|
  key = "search.google_api.#{options[:locale]}"

  statsd.increment(key)
  statsd.timing(key, (ends - starts))
end

Nunes.subscribe(statsd)
