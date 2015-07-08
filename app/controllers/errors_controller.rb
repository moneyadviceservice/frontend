class ErrorsController < ApplicationController
  include Gaffe::Errors
  include SuppressMenuButton

  def show
    render "#{@rescue_response}", status: @status_code
  end

  def display_skip_to_main_navigation?
    @status_code != '404'
  end
end
