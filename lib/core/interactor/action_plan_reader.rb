module Core
  class ActionPlanReader < BaseContentReader
    private

    def entity_class
      ActionPlan
    end

    def repository
      Registry::Repository[:action_plan]
    end
  end
end
