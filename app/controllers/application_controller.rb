require 'core/interactors/category_navigation_reader'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Localisation

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def category_navigation
    @category_navigation ||= Core::CategoryNavigationReader.new.call
  end
  helper_method :category_navigation
end
