class Faraday::Request::HostHeader < Faraday::Middleware
  def call(env)
    host_header = ENV['FARADAY_HOST']
    env[:request_headers]['Host'] = host_header if host_header

    @app.call(env)
  end
end

Faraday::Request.register_middleware host_header: Faraday::Request::HostHeader
