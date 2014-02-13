module World
  module ActionPlans
    def current_action_plan
      @current_action_plan ||=  build(:action_plan)
    end
  end
end

World(World::Action_plans)
