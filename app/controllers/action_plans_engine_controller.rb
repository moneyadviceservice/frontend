class ActionPlansEngineController < MountController
  def parent_template
    'layouts/engine_unconstrained'
  end

  def category_id
    'redundancy'
  end

  def breadcrumbs
    categories.map(&Breadcrumb.public_method(:new))
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
    EngineMountPoint::ActionPlans::EN_ID
  end

  def cy_engine_id
    EngineMountPoint::ActionPlans::CY_ID
  end
end
