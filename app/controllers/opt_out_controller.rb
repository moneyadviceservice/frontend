class OptOutController < ApplicationController
  def create
    cookies.permanent[:roptin] = 0
    redirect_to(:back)
  end
end
