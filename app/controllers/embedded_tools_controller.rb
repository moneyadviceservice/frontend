class EmbeddedToolsController < ApplicationController
  protected

  def breadcrumbs
    BreadcrumbTrail.build(category, category_tree)
  end

  def alternate_url
    # First dup the params for the current request
    new_params = params.dup

    # Since we can't influence the locale and tool_id in the mount point for this app,
    # we override :script_name instead.
    new_params[:script_name] = base_alternate_url

    # Remove the locale and tool_id as we've dealt with those in the script_name.
    # (And if we don't they'll be added to the query string.)
    new_params.delete_if { |key, _| %w(locale tool_id).include?(key) }

    url = url_for(new_params)

    if mount_point.respond_to? :alternate_url
      mount_point.alternate_url(url, alternate_locale)
    else
      url
    end
  end

  helper_method :alternate_url

  helper_method :breadcrumbs

  def category
    @category ||= ToolCategory.new(category_id)
  end

  def alternate_options
    {
      "#{params[:locale]}-GB" => request.url,
      "#{alternate_locale }-GB" => alternate_url
    }
  end

  helper_method :alternate_options

  def mount_point
    @mount_point ||= ToolMountPoint.for(engine_name)
  end

  def engine_name
    self.class.parent.name.underscore
  end

  def alternate_locale
    @alternate_locale ||= mount_point.alternate_locale(params[:locale])
  end

  helper_method :alternate_locale

  def alternate_tool_id
    @alternate_tool_id ||= mount_point.alternate_tool_id(params[:tool_id])
  end

  helper_method :alternate_tool_id

  def contact_panels_border_top?
    true
  end

  def display_menu_button_in_header?
    false
  end

  def display_category_directory?
    true
  end

  helper_method :display_category_directory?

  def exclude_syndicated_iframe_resizer?
    false
  end

  helper_method :exclude_syndicated_iframe_resizer?

  def base_alternate_url
    "/#{alternate_locale}/tools/#{alternate_tool_id}"
  end
end
