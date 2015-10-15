class QuizController < EmbeddedToolsController
  protected
  def category_id
    ''
  end

  def syndicated_tool_request?
    true
  end

  helper_method :category_id
end
