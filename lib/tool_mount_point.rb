require_relative '../lib/tool_mount_point/base'
require_relative '../lib/tool_mount_point/mortgage_calculator'

module ToolMountPoint
  def self.for(tool)
    "ToolMountPoint::#{tool.to_s.camelize}".constantize.new
  end
end
