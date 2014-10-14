class BudgetPlannerController < EmbeddedToolsController
  protected

  def incognito?
    params.key?(:incognito)
  end

  helper_method :incognito

  def category_id
    'managing-money'
  end
end
