require_dependency 'html_processor/base'

module HTMLProcessor
  class VideoWrapper < Base
    def process(*xpaths)
      doc.xpath(*xpaths).each do |node|
        node.parent.name == 'p' ? swap_node(node.parent) : swap_node(node)
      end
      super
    end

    def swap_node(node)
      node.replace(HTMLProcessor::VIDEO_TAG_WRAPPER).first << node
    end
  end
end
