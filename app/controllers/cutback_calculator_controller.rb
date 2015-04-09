class CutbackCalculatorController < EmbeddedToolsController 
  def alternate_url
    new_params = { script_name: "/#{alternate_locale}/tools/#{alternate_tool_id}" }
    url = url_for(new_params)

    if mount_point.respond_to? :alternate_url
      mount_point.alternate_url(url, alternate_locale)
    else
      url
    end
  end

  protected

  def category_id
    'managing-money'
  end
end
