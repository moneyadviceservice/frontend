require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'
require 'core/repositories/search/google_custom_search_response_mapper'

module Core::Repositories
  module Search
    class GoogleCustomSearch < Core::Repository
      EVENT_NAME = 'request.google_api.search'

      def initialize
        self.connection = Core::Registries::Connection[:google_api]
      end

      def perform(query)
        mapper  = GoogleCustomSearchResponseMapper.new
        options = { key: ENV['GOOGLE_API_KEY'], cx: ENV['GOOGLE_API_CX'], q: query }

        mapper.map(connection.get('customsearch/v1', options))

      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
      end

      private

      attr_accessor :connection

    end
  end
end
