module Core::Repositories
  module Search
    class GoogleCustomSearchEngine < Core::Repository
      class ResponseItemMapper

        SECOND_TO_LAST_INDEX = -2

        attr_accessor :data

        def initialize(data)
          self.data = data
        end

        def id
          link_tokens.last
        end

        def title
          data['title']
        end

        def description
          metatags.map { |m| m['og:description'] }.compact.first || ''
        end

        def type
          link_tokens[SECOND_TO_LAST_INDEX].singularize
        end

        def link
          data['link']
        end

        def snippet
          data['snippet']
        end

        def mapped_item_response
          {
            id:          id,
            type:        type,
            description: description,
            title:       title,
            link:        link,
            snippet:     snippet
          }
        end

        private

        def pagemap
          data['pagemap'] || {}
        end

        def metatags
          pagemap['metatags'] || []
        end

        def link_tokens
          data['link'].split('/')
        end

      end
    end
  end
end
