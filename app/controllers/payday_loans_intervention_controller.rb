class PaydayLoansInterventionController < EmbeddedToolsController
  def base_alternate_url
    "/#{alternate_locale}/#{alternate_tool_id}"
  end

  def mount_point
    @mount_point ||= ToolMountPoint.for(:payday_loans)
  end

  def category_id
    'debt-and-borrowing'
  end
end
