module HTMLProcessor
  class TableWrapper < Base
    def process(*xpaths)
      doc.xpath(*xpaths).each { |node| swap_node(node) }
      super
    end

    def swap_node(node)
      node.replace(HTMLProcessor::TABLE_WRAPPER).first << node
    end
  end
end
