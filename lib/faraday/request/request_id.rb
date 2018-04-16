require 'current_request_id'

class Faraday::Request::RequestId < Faraday::Middleware
  def call(env)
    env[:request_headers]['X-Request-Id'] = CurrentRequestId.get if CurrentRequestId.get.present?

    @app.call(env)
  end
end

Faraday::Request.register_middleware request_id: Faraday::Request::RequestId
