class BreadcrumbTrail
  def self.build(item, category_tree)
    as_breadcrumbs do
      if item.categories.empty?
        [HomeCategory.new]
      elsif item.categories.one?
        RootToNodePath.build(item.categories.first, category_tree)
      else
        []
      end
    end
  end

  def self.build_category_trail(item)
    as_breadcrumbs do
      if item.parent_id.present?
        build_trail(item.parent_id)
      else
        [HomeCategory.new]
      end
    end
  end

  def self.build_tool_trail(item)
    as_breadcrumbs do
      if item
        build_trail(item.id)
      else
        [HomeCategory.new]
      end
    end
  end

  def self.build_trail(category_id, children = [])
    category = Mas::Cms::Category.find(category_id, locale: I18n.locale, cached: true)
    children.unshift category
    return [] if category.id == 'corporate-home'
    return children.unshift(HomeCategory.new) if category.parent_id.blank?
    build_trail(category.parent_id, children)
  end

  def self.home
    as_breadcrumbs do
      [HomeCategory.new]
    end
  end

  def self.as_breadcrumbs
    yield.map do |category|
      Breadcrumb.new(category)
    end
  end
end
