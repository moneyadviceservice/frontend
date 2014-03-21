class CookieNoticeAcceptancesController < ApplicationController
  def create
    cookies.permanent[COOKIE_MESSAGE_COOKIE_NAME] = COOKIE_MESSAGE_COOKIE_VALUE

    respond_to do |wants|
      wants.js do
        head :ok
      end
      wants.html do
        redirect_to :back
      end
    end
  end
end
