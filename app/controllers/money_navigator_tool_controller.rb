class MoneyNavigatorToolController < EmbeddedToolsController
  layout 'layouts/engine_syndicated'

  def index; end

  private

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
end
