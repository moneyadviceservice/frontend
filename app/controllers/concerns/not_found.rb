module NotFound
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
