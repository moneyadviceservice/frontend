class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator

  include Navigation

  def show
    @category = Core::CategoryReader.new(params[:id]).call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      else
        not_found
      end
    end

    @breadcrumbs = BreadcrumbTrail.build(@category, category_tree)

    assign_active_categories(@category)
  end
end
