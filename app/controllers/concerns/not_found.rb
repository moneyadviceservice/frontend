module NotFound
  extend ActiveSupport::Concern

  included do
    def not_found
      fail ActionController::RoutingError.new('Not Found')
    end
  end
end
