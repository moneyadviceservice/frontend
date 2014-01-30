module HtmlProcessor
  class NodeRemover

    attr_reader :doc
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def process(*xpaths)
      doc.search(*xpaths).remove
      doc.to_s
    end

  end
end
