require 'core/interactors/action_plan_reader'

class ActionPlansController < ApplicationController

  def show
    @action_plan = Core::ActionPlanReader.new(params[:id]).call
  end
end
