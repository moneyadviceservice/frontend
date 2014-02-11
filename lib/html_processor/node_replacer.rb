module HTMLProcessor
  class NodeReplacer
    attr_accessor :doc
    private :doc=

    def initialize(html)
      self.doc = Nokogiri::HTML.parse(html)
    end

    def process(xpath, new_tag)
      doc.xpath(xpath).each do |node|
        node.name = new_tag
      end

      doc.to_s
    end
  end
end
