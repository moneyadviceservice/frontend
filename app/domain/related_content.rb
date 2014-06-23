class RelatedContent
  def self.build(item, limit = 6)
    category_contents = sibling_and_cousin_contents(item)
    related_content = []

    until category_contents.all?(&:empty?) do
      category_contents.each do |contents|
        related_content << item if item = contents.shift
        return related_content if related_content.count == limit
      end
    end

    related_content
  end

  private

  def self.sibling_and_cousin_contents(item)
    item.categories.map do |category|
      category.contents.reject { |i| i == item }
    end
  end
end
