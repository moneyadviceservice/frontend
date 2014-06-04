module Core
  class BreadcrumbsReader
    attr_accessor :category_id, :category_tree
    private :category_id, :category_tree=

    def initialize(category_id, category_tree)
      self.category_id   = category_id
      self.category_tree = category_tree
    end

    def call(&block)
      if node = category_tree.find { |node| node.name == category_id }
        node.parentage.reverse.collect(&:content)
      else
        block.call if block_given?
      end
    end
  end
end
