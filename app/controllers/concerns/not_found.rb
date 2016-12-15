module NotFound
  def not_found
    fail ActionController::RoutingError.new('Not Found')
  end
end
