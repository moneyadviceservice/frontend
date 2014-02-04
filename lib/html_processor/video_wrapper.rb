module HTMLProcessor
  class VideoWrapper

    attr_reader :doc, :wrapper

    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def process(*xpaths)
      doc.xpath(*xpaths).each do |node|
        node.parent.name == 'p' ? swap_node(node.parent) : swap_node(node)
      end
      doc.to_s
    end

    def swap_node(node)
      node.replace(HTMLProcessor::VIDEO_TAG_WRAPPER).first << node
    end
  end
end
