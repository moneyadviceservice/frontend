class BabyCostCalculatorController < EmbeddedToolsController
  before_action :deny_non_syndicates

  def deny_non_syndicates
    redirect_to main_app.article_path(I18n.t('controllers.baby_cost_calculator.deny_non_syndicates.article_id')), status: 301 unless syndicated_tool_request?
  end

  protected
  def category_id
    'having-a-baby'
  end
  helper_method :category_id
end
