module ToolMountPoint
  class BudgetPlanner < Base
    EN_ID = 'budget-planner'.freeze
    CY_ID = 'cynllunydd-cyllideb'.freeze

    def matches?(request)
      request.params[:incognito] = nil unless request.params[:incognito].to_s.casecmp('incognito').zero?

      super
    end
  end
end
