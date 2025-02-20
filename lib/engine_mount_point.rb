require_relative '../lib/engine_mount_point/base'

module EngineMountPoint
  def self.for(tool)
    "EngineMountPoint::#{tool.to_s.camelize}".constantize.new
  end
end
