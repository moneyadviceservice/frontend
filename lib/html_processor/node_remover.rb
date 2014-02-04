module HTMLProcessor
  class NodeRemover
    attr_reader :doc

    def initialize(html)
      @doc = Nokogiri::HTML.parse(html)
    end

    def process(*xpaths)
      doc.xpath(*xpaths).remove
      doc.to_s
    end
  end
end
