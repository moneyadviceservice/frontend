class OptOutController < ApplicationController
  def create
    cookies.permanent.signed[:roptin] = 0
    redirect_to(:back)
  end
end
