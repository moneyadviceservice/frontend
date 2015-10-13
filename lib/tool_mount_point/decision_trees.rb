module ToolMountPoint
  class DecisionTrees < Base
     EN_ID = 'health-check-questions'
     CY_ID = 'health-check-questions'

     class HealthCheck < Base
       EN_ID = 'health-check-questions'
       CY_ID = 'health-check-questions'
     end

     def initialize
       @health_check_mount_point = HealthCheck.new
     end

     def matches?(request)
       @health_check_mount_point.matches?(request)
     end

     def alternate_tool_id(current_tool_id)
       {
         HealthCheck::EN_ID => HealthCheck::CY_ID,
         HealthCheck::CY_ID => HealthCheck::EN_ID
       }.fetch(current_tool_id)
     end
  end
end
