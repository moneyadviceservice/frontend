class RouteProbe
  class RouteChecker
    def check(method, path)
      Rails.application.routes.recognize_path(path, method: method)
    rescue ActionController::RoutingError
      false
    end
  end

  def initialize(app)
    @app     = app
    @checker = RouteChecker.new
  end

  def call(env)
    if env['HTTP_X_ROUTE_PROBE'] && @checker.check(env['REQUEST_METHOD'], env['PATH_INFO'])
      [200, {}, []]
    else
      @app.call(env)
    end
  end
end
