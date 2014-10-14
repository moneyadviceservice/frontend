module Core::Repository
  module Search
    class GoogleCustomSearchEngine < Core::Repository::Base
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
          data['htmlTitle']
        end

        def link
          data['link']
        end

        def snippet
          data['htmlSnippet']
        end

        def mapped_item_response
          {
            id:          id,
            title:       title,
            link:        link,
            snippet:     snippet
          }
        end

        private

        def link_tokens
          data['link'].split('/')
        end
      end
    end
  end
end
