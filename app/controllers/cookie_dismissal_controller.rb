class CookieDismissalController < ApplicationController
  def create
    cookies['_cookie_dismiss_newsletter'] = { value: 'hide', expires: 1.month.from_now }
    render :nothing => true
  end
end
