class EmployerBestPracticesController < EmbeddedToolsController
  def engine_content?
    false
  end

  def engine_name
    'employer_best_practices'
  end

  def alternate_tool_id
    @alternate_tool_id ||= ToolMountPoint::EmployerBestPractices::EN_ID
  end

  def check_syndicated_layout
    'engine_syndicated' if syndicated_tool_request?
  end
end
