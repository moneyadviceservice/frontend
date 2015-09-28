class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  include Navigation

  def show
    @action_plan = interactor.call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      else
        not_found
      end
    end

    assign_active_categories(*@action_plan.categories)

    @breadcrumbs = BreadcrumbTrail.build(@action_plan, category_tree)
  end

  private

  def interactor
    Core::ActionPlanReader.new(params[:id])
  end
end
