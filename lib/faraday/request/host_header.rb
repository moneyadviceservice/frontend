class Faraday::Request::HostHeader < Faraday::Middleware
  def call(env)
    env[:request_headers]['Host'] = ENV['FARADAY_HOST'] if ENV['FARADAY_HOST']

    @app.call(env)
  end
end

Faraday::Request.register_middleware host_header: Faraday::Request::HostHeader
