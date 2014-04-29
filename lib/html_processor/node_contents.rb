module HTMLProcessor
  class NodeContents < Base
    def process(xpath)
      doc.xpath(xpath).inner_html.to_s
    end
  end
end
