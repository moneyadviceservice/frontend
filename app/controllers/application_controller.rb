require 'core/interactors/category_navigation_reader'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Localisation

  COOKIE_MESSAGE_COOKIE_NAME  = '_cookie_notice'
  COOKIE_MESSAGE_COOKIE_VALUE = 'y'

  DISMISS_BETA_OPT_OUT_COOKIE_NAME  = 'dismiss_opt_out'
  DISMISS_BETA_OPT_OUT_COOKIE_VALUE = 'y'

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def category_navigation
    @category_navigation ||= Core::CategoryNavigationReader.new.call
  end
  helper_method :category_navigation

  def cookies_not_accepted?
    cookies.permanent[COOKIE_MESSAGE_COOKIE_NAME] != COOKIE_MESSAGE_COOKIE_VALUE
  end
  helper_method :cookies_not_accepted?

  def dismissed_beta_opt_out?
    cookies.permanent[DISMISS_BETA_OPT_OUT_COOKIE_NAME] == DISMISS_BETA_OPT_OUT_COOKIE_VALUE
  end
  helper_method :dismissed_beta_opt_out?
end
