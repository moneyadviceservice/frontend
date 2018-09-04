class PacsController < EmbeddedToolsController
  def exclude_syndicated_iframe_resizer?
    true
  end

  protected

  def category_id
    nil
  end
  helper_method :category_id
end
