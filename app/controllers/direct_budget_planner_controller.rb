class DirectBudgetPlannerController < EmbeddedToolsController
  BUDGET_PLANNER_SUMMARY_PATH = '/en/tools/budget-planner/budget/summary'.freeze

  def new
    return redirect_to BUDGET_PLANNER_SUMMARY_PATH if user_signed_in?

    session[:user_return_to] = BUDGET_PLANNER_SUMMARY_PATH

    redirect_to new_user_session_path
  end
end
