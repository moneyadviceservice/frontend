class CookiesDisabledsController < ApplicationController
  layout 'engine_syndicated'

  def show
    @tool = CookiedTool.find_by_tool(params[:tool])

    if cookies[:checked] == 'true'
      cookies.delete(:checked)
      return redirect_to tool_redirect_path
    end
  end

  protected

  def tool_redirect_path
    path = "#{@tool.landing_path}?checked=true"
    path += '&noresize=true' if exclude_syndicated_iframe_resizer?
    path
  end

  def canonical
    nil
  end
  helper_method :canonical

  def alternate_options
    []
  end
  helper_method :alternate_options

  def alternate_url
    nil
  end
  helper_method :alternate_url

  def alternate_locale
    nil
  end
  helper_method :alternate_locale

  def exclude_syndicated_iframe_resizer?
    params.key?(:noresize)
  end
  helper_method :exclude_syndicated_iframe_resizer?
end
