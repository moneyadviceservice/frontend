class OptOutController < ApplicationController
  def create
    cookies.permanent[:roptin] = 0
    redirect_to(redirection_page)
  end

  private

  def redirection_page
    params[:redirection_page] || root_path
  end
end
