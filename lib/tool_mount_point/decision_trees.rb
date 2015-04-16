module ToolMountPoint
  class DecisionTrees < Base
     EN_ID = 'health-check-questions'
     CY_ID = 'health-check-questions'

     class HealthCheck < Base
       EN_ID = 'health-check-questions'
       CY_ID = 'health-check-questions'
     end

     class WorkplacePensionAdviceTool < Base
       EN_ID = 'workplace-pension-advice-tool'
       CY_ID = 'workplace-pension-advice-tool'
     end

     def initialize
       @health_check_mount_point = HealthCheck.new
       @workplace_pension_advice_tool_mount_point = WorkplacePensionAdviceTool.new
     end

     def matches?(request)
       @health_check_mount_point.matches?(request) || @workplace_pension_advice_tool_mount_point.matches?(request)
     end

     def alternate_tool_id(current_tool_id)
       {
         HealthCheck::EN_ID => HealthCheck::CY_ID,
         HealthCheck::CY_ID => HealthCheck::EN_ID,
         WorkplacePensionAdviceTool::EN_ID => WorkplacePensionAdviceTool::CY_ID,
         WorkplacePensionAdviceTool::CY_ID => WorkplacePensionAdviceTool::EN_ID
       }.fetch(current_tool_id)
     end
  end
end
