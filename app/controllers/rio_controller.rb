class RioController < EmbeddedToolsController
  def parent_template
    if syndicated_tool_request?
      response.headers['X-Frame-Options'] = 'ALLOWALL'
      'layouts/engine_syndicated'
    else
      'layouts/engine_unconstrained'
    end
  end

  protected

  def category_id
    'work-pensions-and-retirement'
  end
end
