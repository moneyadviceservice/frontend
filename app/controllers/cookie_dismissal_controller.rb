class CookieDismissalController < ApplicationController
  def create
    cookies[COOKIE_DISMISS_NEWSLETTER_NAME] = { value: COOKIE_HIDE_NEWSLETTER_VALUE, expires: 1.month.from_now }
    head :ok
  end
end
