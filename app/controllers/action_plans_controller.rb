require 'core/interactors/action_plan_reader'

class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  include Navigation

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call do
      not_found
    end

    if Feature.active?(:left_hand_nav)
      render :show_v2
    else
      # (@action_plan.categories.compact.map(&:id) + @action_plan.parent_category_ids).each do |category|
      #   active_category category
      # end

      render :show
    end
  end
end
