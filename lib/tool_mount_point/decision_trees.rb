module ToolMountPoint
  class DecisionTrees < Base
    def alternate_tool_id(current_tool_id)
      {
        'health-check-questions' => 'health-check-questions',
        'workplace-pension-advice-tool' => 'workplace-pension-advice-tool' 
      }.fetch(current_tool_id)
    end
  end
end
