class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator

  include Navigation

  def show
    @category = Mas::Cms::Category.find(params[:id], locale: I18n.locale)
    @breadcrumbs = BreadcrumbTrail.build(@category)
    assign_active_categories(@category)
  end

  private

  def default_main_content_location?
    false
  end
end
