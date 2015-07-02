class RioController < MountController
  def parent_template
    'layouts/engine_unconstrained'
  end

  def category_id
    'using-your-pension-pot'
  end

  def breadcrumbs
    categories.map(&Breadcrumb.public_method(:new))
  end

  private

  def category
    @category ||= Core::CategoryReader.new('work-pensions-and-retirement').call
  end

  def categories
    RootToNodePath.build(category, category_tree)
  end

  def alternate_engine_id
    send "#{alternate_locale}_engine_id"
  end

  def en_engine_id
    EngineMountPoint::Rio::EN_ID
  end

  def cy_engine_id
    EngineMountPoint::Rio::CY_ID
  end
end
