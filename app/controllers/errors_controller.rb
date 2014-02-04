class ErrorsController < ApplicationController

  def show
    render  action: params[:status]
  end
end
