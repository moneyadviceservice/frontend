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

  COOKIE_MESSAGE_COOKIE_NAME = '_cookie_notice'
  COOKIE_MESSAGE_COOKIE_VALUE = 'y'
  def cookies_not_accepted?
    cookies.permanent[COOKIE_MESSAGE_COOKIE_NAME] != COOKIE_MESSAGE_COOKIE_VALUE
  end
  helper_method :cookies_not_accepted?
end
