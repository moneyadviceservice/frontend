require 'current_request_id'

class Faraday::Request::RequestId < Faraday::Middleware
  def call(env)
    request_id = CurrentRequestId.get
    env[:request_headers]['X-Request-Id'] = request_id if request_id

    @app.call(env)
  end
end

Faraday::Request.register_middleware request_id: Faraday::Request::RequestId
