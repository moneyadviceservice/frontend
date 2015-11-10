class ErrorsController < ApplicationController
  include SuppressMenuButton
  layout 'error'
  before_filter :fetch_exception

  def show
    render :show, status: @status_code
  end

  def display_skip_to_main_navigation?
    @status_code != '404'
  end

  private

  def fetch_exception
    @exception = env['action_dispatch.exception']
    @status_code = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
  end
end
