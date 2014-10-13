class BudgetPlannerController < EmbeddedToolsController
  protected

  helper_method def incognito?
                  params.key?(:incognito)
  end

  def category_id
    'managing-money'
  end
end
