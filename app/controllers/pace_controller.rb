class PaceController < ApplicationController
  layout 'pace'

  def show; end
  def privacy; end
  def online
    render layout: false
  end
end
