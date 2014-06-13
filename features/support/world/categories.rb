module World
  module Categories
    attr_accessor :current_category

    def category_containing_no_child_categories
      fixture 'categories/help-with-insurance.yml'
    end

    alias_method :category, :category_containing_no_child_categories

    def category_containing_child_categories
      fixture 'categories/insurance.yml'
    end

    def browse_to_category(category, locale)
      self.current_category = category

      category_page.load(locale: locale, id: category.id)
    end
  end
end

World(World::Categories)
