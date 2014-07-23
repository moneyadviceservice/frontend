class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  include Navigation

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call do
      not_found
    end

    assign_active_categories(*@action_plan.categories)

    @breadcrumbs = BreadcrumbTrail.build(@action_plan, category_tree)
  end
end
