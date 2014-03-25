module HTMLProcessor
  class NodeReplacer < Base
    def process(xpath, new_tag)
      doc.xpath(xpath).each do |node|
        node.name = new_tag
      end
      super
    end
  end
end
