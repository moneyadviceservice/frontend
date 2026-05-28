class DropBudgetPlannerTables < ActiveRecord::Migration
  def change
    drop_table :budget_planner_spreadsheets
    drop_table :budget_planner_budgets
    drop_table :budget_planner_wip_budgets
  end
end
