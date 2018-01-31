class BreadcrumbTrail
  def self.build(item, category_tree = nil)
    case item
    when Mas::Cms::Category
      build_category_trail(item)
    when ToolCategory
      RootToNodePath.build(item, category_tree)
    when Core::StaticPage
      [HomeCategory.new]
    else
      build_default_trail(item, category_tree)
    end.map do |element|
      Breadcrumb.new(element)
    end
  end

  def self.build_category_trail(item)
    if item.parent_id.present?
      build_trail(item.parent_id)
    else
      [HomeCategory.new]
    end
  end

  def self.build_default_trail(item, category_tree)
    if item.categories.empty?
      [HomeCategory.new]
    elsif item.categories.one?
      RootToNodePath.build(item.categories.first, category_tree)
    else
      []
    end
  end

  def self.build_trail(category_id, children = [])
    category = Mas::Cms::Category.find(category_id, locale: I18n.locale)
    children.unshift category
    return [] if category.id == 'corporate-home'
    return children.unshift(HomeCategory.new) if category.parent_id.blank?
    build_trail(category.parent_id, children)
  end

  def self.home
    [Breadcrumb.new(HomeCategory.new)]
  end
end
