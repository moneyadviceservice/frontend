class BreadcrumbTrail
  def self.build(item, category_tree)
    categories = case item
      when Core::Category
        RootToNodePath.build(item, category_tree)[0 ... -1]
      when Core::StaticPage
        [HomeCategory.new]
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
end
