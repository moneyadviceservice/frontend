class BreadcrumbTrail
  def self.build(item, category_tree = nil)
    case item
    when Mas::Cms::Category
      # recurse and find categories instead of passing in category_tree?
      if item.parent_id.present?
        build_trail(item.parent_id)
      else
        [HomeCategory.new]
      end
    when ToolCategory
      RootToNodePath.build(item, category_tree)
    when Core::StaticPage
      [HomeCategory.new]
    when Core::NewsArticle
      [HomeCategory.new, NewsCategory.new]
    else
      if item.categories.empty?
        [HomeCategory.new]
      elsif item.categories.one?
        RootToNodePath.build(item.categories.first, category_tree)
      else
        []
      end
    end.map do |element|
      Breadcrumb.new(element)
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
