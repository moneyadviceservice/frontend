class DebtTestController < EmbeddedToolsController
  def parent_template
    if syndicated_tool_request?
      'layouts/engine_syndicated'
    else
      'layouts/engine_unconstrained'
    end
  end

  protected
    def category_id
      'before-you-borrow'
    end
end
