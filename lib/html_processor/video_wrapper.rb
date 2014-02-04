module HTMLProcessor
  class VideoWrapper

    attr_reader :doc, :wrapper

    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def process(*xpaths)
      doc.xpath(*xpaths).each do |node|
        if node.parent.name == 'p'
          node.parent.replace(HTMLProcessor::VIDEO_TAG_WRAPPER).first << node.parent
        else
          node.replace(HTMLProcessor::VIDEO_TAG_WRAPPER).first << node
        end
      end
      doc.to_s
    end
  end
end
