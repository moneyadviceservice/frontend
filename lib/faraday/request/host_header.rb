class Faraday::Request::HostHeader < Faraday::Middleware
  def call(env)
    if ENV['FARADAY_HOST']
      env[:request_headers]['Host'] = ENV['FARADAY_HOST']
    end

    @app.call(env)
  end
end

Faraday::Request.register_middleware host_header: Faraday::Request::HostHeader
