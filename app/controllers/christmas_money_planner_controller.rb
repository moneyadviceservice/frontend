class ChristmasMoneyPlannerController < EmbeddedToolsController
  
  include SuppressMenuButton
  
  def show
    @breadcrumbs = BreadcrumbTrail.home
    render layout: '_unconstrained'
  end

  def category_id
    'managing-money'
  end

end