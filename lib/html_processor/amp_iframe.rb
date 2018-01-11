require_dependency 'html_processor/base'

module HTMLProcessor
  class AmpIframe < Base
    PERMITTED_AMP_ATTRIBUTES = %w[src
                                  alt
                                  height
                                  width
                                  srcdoc
                                  frameborder
                                  allowfullscreen
                                  allowpaymentrequest
                                  allowtransparency
                                  referrerpolicy
                                  sandbox].freeze

    def process(*xpaths)
      doc.xpath(*xpaths).each do |node|
        if https?(node.attribute('src'))
          amp_iframe = Nokogiri::XML::Node.new 'amp-iframe', doc
          amp_iframe['layout'] = 'responsive'
          copy_attributes!(node, amp_iframe)
          node.replace amp_iframe
        else
          node.remove
        end
      end
      super
    end

    private

    def attributes_to_copy(original_iframe)
      PERMITTED_AMP_ATTRIBUTES & original_iframe.attributes.keys
    end

    def copy_attributes!(original_iframe, amp_iframe)
      attributes_to_copy(original_iframe).each do |field|
        amp_iframe[field] = original_iframe.attribute(field)
      end
    end

    def https?(url)
      url && URI.parse(url).scheme == 'https'
    end
  end
end
