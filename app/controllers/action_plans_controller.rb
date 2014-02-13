require 'core/interactors/action_plan_reader'

class ActionPlansController < ApplicationController
  decorates_assigned :action_plan, with: ActionPlanDecorator

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call
  end
end
