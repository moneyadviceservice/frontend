require 'current_request_id'

module Faraday
  class Request::RequestId < Faraday::Middleware
    def call(env)
      if request_id = CurrentRequestId.get
        env[:request_headers]['X-Request-Id'] = request_id
      end

      @app.call(env)
    end
  end

  register_middleware :request, request_id: Faraday::Request::RequestId
end
