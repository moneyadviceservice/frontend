module HTMLProcessor
  class TableWrapper
    attr_accessor :doc
    private :doc=

    def initialize(html)
      self.doc = Nokogiri::HTML(html)
    end

    def process(*xpaths)
      doc.xpath(*xpaths).each { |node| swap_node(node) }
      doc.to_s
    end

    def swap_node(node)
      node.replace(HTMLProcessor::TABLE_WRAPPER).first << node
    end
  end
end
