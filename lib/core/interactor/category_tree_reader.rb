module Core
  class CategoryTreeReader
    def call(categories = Registry::Repository[:category].all)
      if (categories)
        Tree::TreeNode.new('home', HomeCategory.new).tap do |root|
          categories.each do |attributes|
            build_tree(root, attributes)
          end
        end
      elsif block_given?
        yield
      end
    end

    private

    def build_tree(node, attributes)
      id       = attributes.delete('id')
      contents = attributes.delete('contents')
      return unless attributes.delete('type') == 'category'

      category = category_builder(id, attributes)
      category_node = node_builder(id, category)

      contents.each do |content_attributes|
        build_tree(category_node, content_attributes)
      end

      node << category_node
    end

    def category_builder(id, attributes)
      Category.new(id, attributes)
    end

    def node_builder(id, category)
      Tree::TreeNode.new(id, category)
    end
  end
end
