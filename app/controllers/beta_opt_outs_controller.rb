class BetaOptOutsController < ApplicationController
  BETA_OPT_OUT_COOKIE_NAME = 'roptin'
  BETA_OPT_OUT_COOKIE_VALUE = 0

  skip_before_action :store_location

  def create
    cookies.permanent[BETA_OPT_OUT_COOKIE_NAME] = BETA_OPT_OUT_COOKIE_VALUE
    redirect_to(redirection_page)
  end

  private

  def redirection_page
    params[:redirection_page] || root_path
  end
end
