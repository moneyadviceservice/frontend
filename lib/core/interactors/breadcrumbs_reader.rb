module Core
  class BreadcrumbsReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      if(tree = CategoryTreeReader.new.call)
        target_node = find_node(tree)

        target_node ? target_node.parentage.map(&:content) : []
      else
        block.call if block_given?
      end
    end

    private

    def find_node(tree)
      tree.select { |node| node.name == id}.first
    end
  end
end
