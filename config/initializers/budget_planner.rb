module BudgetPlanner
  CommitBudgetCommand = Struct.new(:wip_budget_id, :step_name)

  def self.const_missing(name)
    const_set(name, Class.new)
  end
end
