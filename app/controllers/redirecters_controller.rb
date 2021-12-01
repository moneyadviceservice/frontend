class RedirectersController < ApplicationController
  # This controller works around the Safari "No third-party cookies in cross-domain iframes unless that iframe has previously set a cookie outside of an iframe"
  # issue. We redirect from AEM to this controller, which sets a cookie and then redirects back to the tool.

  def redirect
    locale = params[:locale]
    tool_name = params[:tool_name].to_sym

    set_initial_cookie

    tool_url = url_for_tool(locale, tool_name)

    if tool_url.present?
      redirect_to tool_url
    else
      not_found
    end
  end

  private

  def url_for_tool(locale, tool_name)
    if tool_name == :debt_advice_locator
      "https://www.moneyhelper.org.uk/#{locale}/money-troubles/dealing-with-debt/debt-advice-locator"
    end
  end

  def set_initial_cookie
    cookies[:safari_initial_cookie] = 'Safari initial cookie'
  end
end
