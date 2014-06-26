require 'core/entities/category'
require 'core/registries/repository'

module Core
  class CategoryTreeReader
    def call(&block)
      if (categories = Registries::Repository[:category].all)
        Tree::TreeNode.new('home', HomeCategory.new).tap do |root|
          categories.each do |attributes|
            build_tree(root, attributes)
          end
        end
      else
        block.call if block_given?
      end
    end

    private

    def build_tree(node, attributes)
      id       = attributes.delete('id')
      contents = attributes.delete('contents')

      category      = Category.new(id, attributes)
      category_node = Tree::TreeNode.new(id, category)

      contents.each do |content_attributes|
        build_tree(category_node, content_attributes)
      end

      node << category_node
    end
  end
end
