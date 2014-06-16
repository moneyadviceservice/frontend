class BreadcrumbTrail
  def self.build(item, category_tree)
    categories = if item.is_a?(Core::Category)
      RootToNodePath.build(item, category_tree)[0 ... -1]
    else
      if item.categories.one?
        RootToNodePath.build(item.categories.first, category_tree)
      else
        []
      end
    end

    categories.map(&Breadcrumb.public_method(:new))
  end
end
