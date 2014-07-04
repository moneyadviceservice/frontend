class BreadcrumbTrail
  def self.build(item, category_tree)
    categories = case item
      when Core::Category
        if item.parent_id.present?
          RootToNodePath.build(item, category_tree)[0 ... -1]
        else
          [HomeCategory.new]
        end
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
    end

    categories.map(&Breadcrumb.public_method(:new))
  end

  def self.home
    [Breadcrumb.new(HomeCategory.new)]
  end
end
