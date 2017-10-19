class WpccController < EmbeddedToolsController
  def exclude_syndicated_iframe_resizer?
    true
  end

  protected

  def category_id
    ''
  end
  helper_method :category_id
end
