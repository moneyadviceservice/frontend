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

    alias_method :action_plan_with_single_parent, :action_plan

    def action_plan_with_two_child_and_one_parent_category
      fixture 'action_plans/decide-whether-to-rent-or-buy.yml'
    end

    def action_plan_with_multiple_parents
      fixture 'action_plans/claim-work-entitlements-when-pregnant.yml'
    end

    def action_plan_in_multiple_categories
      fixture 'action_plans/how-to-manage-your-money-better.yml'
    end

    def orphan_action_plan
      fixture 'action_plans/claim-child-maintenance-from-your-ex.yml'
    end
  end
end

World(World::ActionPlans)
