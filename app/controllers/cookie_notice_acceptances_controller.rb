class CookieNoticeAcceptancesController < ApplicationController
  def create
    cookies.permanent[COOKIE_MESSAGE_COOKIE_NAME] = COOKIE_MESSAGE_COOKIE_VALUE
    redirect_to :back
  end
end
