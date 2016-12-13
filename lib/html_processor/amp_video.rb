require_dependency 'html_processor/base'

module HTMLProcessor
  class AmpVideo < Base
    URI_REGEX = %r|http[s]?://www.youtube.com/embed/([^?#]*)[?]?.*|

    def process(*xpaths)
      doc.xpath(*xpaths).each do |node|
        video_id = get_video_id(node.attribute('src').value)
        if video_id
          node.replace "<amp-youtube data-videoid='#{video_id}' layout='responsive' width='480' height='270'></amp-youtube>"
        else
          node.remove
        end
      end
      super
    end

    private

    def get_video_id(url)
      match = URI_REGEX.match url
      match[1] unless match.nil?
    end
  end
end
