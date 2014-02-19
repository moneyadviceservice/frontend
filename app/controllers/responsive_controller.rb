class ResponsiveController < ApplicationController
  def opt_out
    cookies.permanent.signed[:roptout] = 0
    redirect_to(:back)
  end
end
