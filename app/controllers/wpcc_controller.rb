class WpccController < EmbeddedToolsController
  def exclude_syndicated_iframe_resizer?
    true
  end

  protected

  def category_id
    'pensions-and-retirement'
  end
  helper_method :category_id
end
