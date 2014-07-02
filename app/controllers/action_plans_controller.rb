class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@action_plan, category_tree)
  end
end
