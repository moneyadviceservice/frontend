class BabyCostCalculatorController < EmbeddedToolsController
  before_action :deny_non_syndicates

  def deny_non_syndicates
    unless syndicated_tool_request?
      redirect_to main_app.article_path(
        I18n.t('controllers.baby_cost_calculator.deny_non_syndicates.article_id')
      ), status: :moved_permanently
    end
  end

  protected

  def category_id
    'having-a-baby'
  end
  helper_method :category_id
end
