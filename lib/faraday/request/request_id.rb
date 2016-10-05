require 'current_request_id'

class Faraday::Request::RequestId < Faraday::Middleware
  def call(env)
    if CurrentRequestId.get.present?
      env[:request_headers]['X-Request-Id'] = CurrentRequestId.get
    end

    @app.call(env)
  end
end

Faraday::Request.register_middleware request_id: Faraday::Request::RequestId
