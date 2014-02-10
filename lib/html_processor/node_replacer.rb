module HTMLProcessor
  class NodeReplacer

    attr_reader :doc

    def initialize(html)
      @doc = Nokogiri::HTML.parse(html)
    end

    def process(xpath, new_tag)
      doc.xpath(xpath).each do |node|
        node.name = new_tag
      end
      doc.to_s
    end
  end
end
