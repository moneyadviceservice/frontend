module HTMLProcessor
  class Base
    attr_reader :doc

    def initialize(html)
      @doc = Nokogiri::HTML.parse(html)
    end

    def process(*args)
      doc.xpath('//body').inner_html.to_s
    end
  end
end
