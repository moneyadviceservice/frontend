module World
  module ActionPlans
    attr_accessor :current_action_plan

    def browse_to_action_plan(action_plan)
      self.current_action_plan = action_plan

      action_plan_page.load(locale: action_plan.locale, id: action_plan.id)
    end

    def action_plan(locale = 'English')
      case locale.to_s
        when 'en', 'English'
          fixture 'action_plans/how-to-open-a-bank-account.yml'
        when 'cy', 'Welsh'
          fixture 'action_plans/sut-i-agor-cyfrif-banc.yml'
        else
          raise ArgumentError, "invalid action plan locale `#{locale}'"
      end
    end
  end
end

World(World::ActionPlans)
