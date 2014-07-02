class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator

  include Navigation

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@category, category_tree)

    active_category @category.id
    active_category @category.parent_id if @category.child?
  end
end
