class OptOutController < ApplicationController
  def create
    cookies.permanent.signed[:roptout] = 0
    redirect_to(:back)
  end
end
