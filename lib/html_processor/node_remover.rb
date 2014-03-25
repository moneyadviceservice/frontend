module HTMLProcessor
  class NodeRemover < Base
    def process(*xpaths)
      doc.xpath(*xpaths).remove
      super
    end
  end
end
