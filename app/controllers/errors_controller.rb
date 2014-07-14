class ErrorsController < ApplicationController
  include Gaffe::Errors

  def show
    render :show, status: @status_code
  end

  def display_menu_button_in_header?
    false
  end

  def display_skip_to_main_navigation?
    @status_code != '404'
  end
end
