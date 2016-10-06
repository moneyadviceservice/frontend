class Faraday::Request::XForwardedProto < Faraday::Middleware
  def call(env)
    if ENV['FARADAY_X_FORWARDED_PROTO']
      env[:request_headers]['X-Forwarded-Proto'] = ENV['FARADAY_X_FORWARDED_PROTO']
    end

    @app.call(env)
  end
end

Faraday::Request.register_middleware x_forwarded_proto: Faraday::Request::XForwardedProto
