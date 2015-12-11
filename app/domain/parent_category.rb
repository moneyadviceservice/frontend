class ParentCategory
  def self.find(page, category_tree)
    page_categories = page_categories_for(page, category_tree)

    parent_category = page_categories.reject do |category|
      category.home? || category.parent_id.present?
    end

    parent_category.first
  end

  def self.page_categories_for(page, category_tree)
    page_category = page.categories.first
    categories = RootToNodePath.build(page_category, category_tree) if page_category

    Array(categories)
  end
end
