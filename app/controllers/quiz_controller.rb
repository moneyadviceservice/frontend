class QuizController < EmbeddedToolsController
  def syndicated_tool_request?
    true
  end

  protected

  def category_id
    ''
  end

  helper_method :category_id
end
