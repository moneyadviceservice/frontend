require_dependency 'html_processor/base'

module HTMLProcessor
  class AmpImg < Base
    PERMITTED_AMP_ATTRIBUTES = %w[
      src
      srcset
      sizes
      alt
      attribution
      height
      width
    ].freeze

    def process(*xpaths)
      doc.xpath(*xpaths).each do |node|
        if node.attributes.include? 'src'
          amp_img = Nokogiri::XML::Node.new 'amp-img', doc
          amp_img['layout'] = 'responsive'
          copy_attributes!(node, amp_img)
          append_noscript_fallback(node, amp_img)
          node.replace amp_img
        else
          node.remove
        end
      end
      super
    end

    private

    def attributes_to_copy(original_image)
      PERMITTED_AMP_ATTRIBUTES & original_image.attributes.keys
    end

    def copy_attributes!(original_image, amp_img)
      attributes_to_copy(original_image).each do |field|
        amp_img[field] = original_image.attribute(field)
      end
    end

    def append_noscript_fallback(original_image, amp_img)
      noscript_node = Nokogiri::XML::Node.new 'noscript', doc
      noscript_node.add_child(original_image.clone)
      amp_img.add_child(noscript_node)
    end
  end
end
