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
      doc.xpath(*xpaths).each do |original_img|
        if original_img.attributes.include? 'src'
          container = create_container
          amp_img = create_amp_img(original_img)
          container.add_child(amp_img)
          original_img.replace container
        else
          original_img.remove
        end
      end
      super
    end

    private

    def create_container
      node = Nokogiri::XML::Node.new 'div', doc
      node['class'] = 'amp-img-container'
      node
    end

    def create_amp_img(original_img)
      amp_img = Nokogiri::XML::Node.new 'amp-img', doc
      amp_img['layout'] = 'fill'
      amp_img['class'] = 'contain'
      copy_attributes!(original_img, amp_img)
      append_noscript_fallback(original_img, amp_img)
      amp_img
    end

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
