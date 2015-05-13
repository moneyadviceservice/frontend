class ActionPlansEngineController < EmbeddedToolsController
  def parent_template
    if syndicated_tool_request?
      'layouts/engine_syndicated'
    else
      'layouts/engine_unconstrained'
    end
  end

  def category_id
    'redundancy'
  end

  def breadcrumbs
    categories.map(&Breadcrumb.public_method(:new))
  end

  def mount_point
    @mount_point ||= ToolMountPoint::ActionPlans.new
  end

  private

  def category
    @category ||= Core::CategoryReader.new(category_id).call
  end

  def categories
    RootToNodePath.build(category, category_tree)
  end

  def alternate_engine_id
    send "#{alternate_locale}_engine_id"
  end

  def en_engine_id
    ToolMountPoint::ActionPlans::EN_ID
  end

  def cy_engine_id
    ToolMountPoint::ActionPlans::CY_ID
  end
end
