class ErrorsController < ApplicationController
  include Gaffe::Errors

  def show
    render :show, status: @status_code
  end
end
