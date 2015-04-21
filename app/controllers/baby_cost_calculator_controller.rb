class BabyCostCalculatorController < EmbeddedToolsController
  protected
  def category_id
    'having-a-baby'
  end
  helper_method :category_id
end
