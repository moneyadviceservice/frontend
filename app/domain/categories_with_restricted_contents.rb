class CategoriesWithRestrictedContents
  def self.build(categories, items)
    categories.map do |category|
      category.clone.tap do |cat|
        cat.contents = category.contents.select { |item| items.member?(item) }
      end
    end
  end
end
