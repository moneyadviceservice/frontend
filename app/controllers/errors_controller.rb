class ErrorsController < EmbeddedToolsController
  before_action :fetch_exception

  layout 'engine_syndicated'

  def show
    render :show, status: params[:status_code], formats: [:html]
  end

  private

  def canonical
    ''
  end
  helper_method :canonical

  def syndicated_tool_request?
    true
  end
  helper_method :syndicated_tool_request?

  def alternate_locale
    nil
  end
  helper_method :alternate_locale

  def alternate_options
    { 'en-GB' => request.url }
  end
  helper_method :alternate_options

  def alternate_url
    nil
  end
  helper_method :alternate_url

  def engine_content?
    true
  end
  helper_method :engine_content?

  def fetch_exception
    @exception = env['action_dispatch.exception']
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
  end
end
