class DirectBudgetPlannerController < EmbeddedToolsController
  ENGLISH_BUDGET_PLANNER_SUMMARY_PATH = '/en/tools/budget-planner/budget/summary'.freeze
  WELSH_BUDGET_PLANNER_SUMMARY_PATH   = '/cy/tools/cynllunydd-cyllideb/budget/summary'.freeze

  def new
    return redirect_to summary_path_for(locale) if user_signed_in?

    session[:user_return_to] = summary_path_for(locale)

    redirect_to new_user_session_path(locale: locale)
  end

  private

  def locale
    I18n.locale
  end

  def summary_path_for(locale)
    if locale == :en
      ENGLISH_BUDGET_PLANNER_SUMMARY_PATH
    else
      WELSH_BUDGET_PLANNER_SUMMARY_PATH
    end
  end
end
