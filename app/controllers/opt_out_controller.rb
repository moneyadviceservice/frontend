class OptOutController < ApplicationController
  def create
    cookies.permanent[:roptin] = 0
<<<<<<< HEAD
    redirect_to(:back)
=======
    redirect_to(redirection_page)
  end

  private

  def redirection_page
    params[:redirection_page] || root_path
>>>>>>> master
  end
end
