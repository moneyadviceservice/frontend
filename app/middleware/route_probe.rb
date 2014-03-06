class RouteProbe
  def initialize(app)
    @app = app
  end

  def call(env)
    Rails.application.routes.recognize_path(env['PATH_INFO'], method: env['REQUEST_METHOD'])

    if env['HTTP_X_ROUTE_PROBE']
      [200, {}, []]
    else
      @app.call(env)
    end
  rescue ActionController::RoutingError
    [501, {}, []]
  end
end
