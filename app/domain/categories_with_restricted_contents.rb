class CategoriesWithRestrictedContents
  def self.build(categories, items)
    categories.map do |category|
      category.clone.tap do |cat|
        cat.contents = category.contents.each_with_object([]) do |item, memo|
          memo << item if items.delete(item)
        end
      end
    end
  end
end
