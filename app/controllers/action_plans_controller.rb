require 'core/interactors/action_plan_reader'

class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call do
      not_found
    end

    render Feature.active?(:left_hand_nav) ? :show_v2 : :show
  end
end
