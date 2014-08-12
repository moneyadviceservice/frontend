require_dependency 'html_processor/base'

module HTMLProcessor
  class HeadingAttributes < Base
    def process(xpath)
      doc.xpath(xpath).each do |node|
        node.set_attribute('role', 'heading')
        node.set_attribute('aria-level', node.name.last)
      end
      super
    end
  end
end
