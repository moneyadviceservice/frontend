class ErrorsController < ApplicationController
  layout 'error'
  before_action :fetch_exception

  def show
    render :show, status: params[:status_code], formats: [:html]
  end

  def display_skip_to_main_navigation?
    params[:status_code] != '404'
  end

  private

  def fetch_exception
    @exception = env['action_dispatch.exception']
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
  end
end
