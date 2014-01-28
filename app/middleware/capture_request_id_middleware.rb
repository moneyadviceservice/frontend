class CaptureRequestIdMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    request_id = env['action_dispatch.request_id']
    Thread.current['request-id'] = request_id
    @app.call(env)
  end
end