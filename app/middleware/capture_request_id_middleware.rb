require 'current_request_id'

class CaptureRequestIdMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request_id = env['action_dispatch.request_id']
    CurrentRequestId.set(request_id)
    @app.call(env)
  end
end
