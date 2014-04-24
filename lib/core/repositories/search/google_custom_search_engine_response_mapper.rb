module Core::Repositories
  module Search
    class GoogleCustomSearchEngineResponseMapper
      SECOND_TO_LAST = -2

      def map(response)
        items = response.body.fetch('items', [])
        items.map do |item|
          link_tokens = item['link'].split('/')
          {
            id:          link_tokens.last,
            type:        link_tokens[SECOND_TO_LAST].singularize,
            description: extract_description(item),
            title:       item['title'],
            link:        item['link'],
            snippet:     item['snippet']
          }
        end
      end

      private

      def extract_description(item)
        return '' unless item.key?('pagemap')

        description = ''
        metatags_array = item['pagemap']['metatags']
        metatags_array.each do |metatags|
          metatags.each { |key, value| return description = value if key == 'og:description' }
        end

        description
      end
    end
  end
end
