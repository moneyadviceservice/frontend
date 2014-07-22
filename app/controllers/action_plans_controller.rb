class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  include Navigation

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call do
      not_found
    end

    add_active_categories(@action_plan.categories)

    @breadcrumbs = BreadcrumbTrail.build(@action_plan, category_tree)
  end

  private

  def add_active_categories(categories)
    categories.each do |category|
      active_category category.id
      active_category category.parent_id if category.child?
    end
  end
end
