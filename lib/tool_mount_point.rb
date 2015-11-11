require_relative '../lib/tool_mount_point/base'
require_relative '../lib/tool_mount_point/action_plans'
require_relative '../lib/tool_mount_point/advice_plans'
require_relative '../lib/tool_mount_point/agreements'
require_relative '../lib/tool_mount_point/budget_planner'
require_relative '../lib/tool_mount_point/baby_cost_calculator'
require_relative '../lib/tool_mount_point/contribution_calculator'
require_relative '../lib/tool_mount_point/car_cost_tool'
require_relative '../lib/tool_mount_point/cutback_calculator'
require_relative '../lib/tool_mount_point/debt_and_mental_health'
require_relative '../lib/tool_mount_point/debt_advice_locator'
require_relative '../lib/tool_mount_point/debt_free_day_calculator'
require_relative '../lib/tool_mount_point/debt_test'
require_relative '../lib/tool_mount_point/decision_trees'
require_relative '../lib/tool_mount_point/mortgage_calculator'
require_relative '../lib/tool_mount_point/payday_loans'
require_relative '../lib/tool_mount_point/pensions_calculator'
require_relative '../lib/tool_mount_point/savings_calculator'
require_relative '../lib/tool_mount_point/timelines'
require_relative '../lib/tool_mount_point/christmas_money_planner'
require_relative '../lib/tool_mount_point/quiz'

module ToolMountPoint
  def self.for(tool)
    "ToolMountPoint::#{tool.to_s.camelize}".constantize.new
  end
end
