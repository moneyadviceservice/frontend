require_relative '../lib/tool_mount_point/base'
require_relative '../lib/tool_mount_point/pensions_calculator'
require_relative '../lib/tool_mount_point/budget_planner'

module ToolMountPoint

  def self.for(tool)
    "ToolMountPoint::#{tool.to_s.camelize}".constantize.new
  end

end
