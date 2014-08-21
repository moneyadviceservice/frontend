class EmbeddedToolsController < ApplicationController

  def parent_template
    'layouts/engine'
  end

  helper_method :parent_template

  def alternate_url
    # First dup the params for the current request
    new_params = params.dup

    # Since we can't influence the locale and tool_id in the mount point for this app,
    # we override :script_name instead.
    new_params[:script_name] = "/#{alternate_locale}/tools/#{alternate_tool_id}"

    # Remove the locale and tool_id as we've dealt with those in the script_name.
    # (And if we don't they'll be added to the query string.)
    new_params.delete_if { |key, _| ['locale', 'tool_id'].include?(key) }

    url_for(new_params)
  end

  helper_method :alternate_url

  def alternate_options
    {
      "#{params[:locale]}-GB" => url_for(params),
      "#{alternate_locale }-GB"=> alternate_url
    }
  end

  helper_method :alternate_options

  def mount_point
    @mount_point ||= ToolMountPoint.for(engine_name)
  end

  def engine_name
    if self.class.parent == PensionsCalculator
      :pensions_calculator
    end
  end

  def alternate_locale
    @alternate_locale ||= mount_point.alternate_locale(params[:locale])
  end

  helper_method :alternate_locale

  def alternate_tool_id
    @alternate_tool_id ||= mount_point.alternate_tool_id(params[:tool_id])
  end

  helper_method :alternate_tool_id

end
