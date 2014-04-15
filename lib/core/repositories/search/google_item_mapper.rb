module Core::Repositories
  module Search
    class GoogleItemMapper
      SECOND_TO_LAST = -2

      def map(item)
        {
          id:          item['link'].split('/').last,
          type:        item['link'].split('/')[SECOND_TO_LAST].singularize,
          description: extract_description(item['pagemap']['metatags']),
          title:       item['title']
        }
      end

      private

      def extract_description(metatags_array)
        description = ''
        metatags_array.each do |metatags|
          metatags.each { |key, value| return description = value if key == 'og:description' }
        end

        description
      end
    end
  end
end
