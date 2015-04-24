module Core
  class CategoryTreeReaderWithDecorator < CategoryTreeReader
    private

    def category_builder(id, attributes)
      CategoryDecorator.new(Category.new(id, attributes))
    end
  end
end
