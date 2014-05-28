module Core
  class CategoryParentsReader

    def initialize(category)
      self.parent_id = category && category.parent_id
    end

    def call
      build_parents(parent_id).reverse
    end

    private

    attr_accessor :parent_id

    def build_parents(parent_id, parents = [])
      return parents unless parent_id

      parent = CategoryReader.new(parent_id).call
      parents << parent
      build_parents(parent.parent_id, parents)
    end

  end
end
