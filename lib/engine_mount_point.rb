require_relative '../lib/engine_mount_point/base'
require_relative '../lib/engine_mount_point/rio'
require_relative '../lib/engine_mount_point/action_plans'

module EngineMountPoint
  def self.for(tool)
    "EngineMountPoint::#{tool.to_s.camelize}".constantize.new
  end
end
