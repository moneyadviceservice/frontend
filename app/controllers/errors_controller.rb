class ErrorsController < ApplicationController
  layout 'error'
  before_filter :fetch_exception

  def show
    render :show, status: @status_code, formats: [:html]
  end

  def display_skip_to_main_navigation?
    @status_code != '404'
  end

  private

  def fetch_exception
    @exception = if env['action_dispatch.request.path_parameters'][:status_code] == '404'
       ActionController::RoutingError.new(:page_not_found)
      else
        env['action_dispatch.exception']
      end
    @status_code = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
  end
end
