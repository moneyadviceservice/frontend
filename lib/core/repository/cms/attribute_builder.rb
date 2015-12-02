module Core::Repository
  module CMS
    class AttributeBuilder
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def self.build(response)
        new(response).attributes
      end

      def attributes
        attributes = response.body

        set_title_from_label(attributes)
        set_body_from_content_block(attributes)

        translate_attributes_from_raw_blocks(attributes)
        group_nested_attributes(attributes)

        set_description(attributes)
        set_categories(attributes)
        set_alternates(attributes)

        attributes
      end

      private

      def set_title_from_label(attributes)
        attributes['title'] = attributes['label']
      end

      def set_body_from_content_block(attributes)
        attributes['body'] = BlockComposer.new(attributes['blocks']).to_html
      end

      def set_description(attributes)
        attributes['description'] = attributes['meta_description']
      end

      def set_categories(attributes)
        attributes['categories'] = attributes['category_names']
      end

      def set_alternates(attributes)
        attributes['alternates']  = Array(attributes['translations']).map do |translation|
          { url: translation['link'], title: translation['label'], hreflang: translation['language'] }
        end
      end

      def translate_attributes_from_raw_blocks(attributes)
        attributes['blocks'].select {|h| h['identifier'].start_with?('raw_') }.each do |h|
          key = h['identifier'].gsub(/^raw_/, '')
          attributes[key] = h['content']
        end
      end

      def group_nested_attributes(attributes)
        attributes.select {|k,_| k.match(/_(\d+)_/) }.each do |k,v|
          _, object, number, field = k.match(/(\w+)_(\d+)_(\w+)/).to_a
          index = number.to_i - 1
          key = object.pluralize

          attributes[key] ||= []
          attributes[key][index] ||= {}
          attributes[key][index][field] = v
        end
      end
    end
  end
end
