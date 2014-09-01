module ToolMountPoint
  class BudgetPlanner < Base
    EN_ID = 'budget-planner'
    CY_ID = 'cynllunydd-cyllideb'

    def matches?(request)
      unless request.params[:incognito].to_s.downcase == 'incognito'
        request.params[:incognito] = nil
      end

      super
    end
  end
end
