module HTMLProcessor
  class NodeRemover
    attr_reader :doc

    def initialize(html)
      @doc = Nokogiri::XML::DocumentFragment.parse(html)
    end

    def process(*xpaths)
      doc.search(*xpaths).remove
      doc.to_s
    end
  end
end
