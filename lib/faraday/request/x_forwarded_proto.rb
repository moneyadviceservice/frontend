class Faraday::Request::XForwardedProto < Faraday::Middleware
  def call(env)
    env[:request_headers]['X-Forwarded-Proto'] = ENV['FARADAY_X_FORWARDED_PROTO'] if ENV['FARADAY_X_FORWARDED_PROTO']

    @app.call(env)
  end
end

Faraday::Request.register_middleware x_forwarded_proto: Faraday::Request::XForwardedProto
