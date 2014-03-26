class BetaOptOutsController < ApplicationController
  BETA_OPT_OUT_COOKIE_NAME = 'roptin'
  BETA_OPT_OUT_COOKIE_VALUE = 0

  def create
    cookies.permanent[BETA_OPT_OUT_COOKIE_NAME] = BETA_OPT_OUT_COOKIE_VALUE
    redirect_to(redirection_page)
  end

  def destroy
    cookies.permanent[DISMISS_BETA_OPT_OUT_COOKIE_NAME] = DISMISS_BETA_OPT_OUT_COOKIE_VALUE

    respond_to do |wants|
      wants.js do
        head :ok
      end
      wants.html do
        redirect_to :back
      end
    end
  end

  private

  def redirection_page
    params[:redirection_page] || root_path
  end
end
