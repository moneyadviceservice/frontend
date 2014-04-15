require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'
require 'core/repositories/search/google_item_mapper'

module Core::Repositories
  module Search
    class Google < Core::Repository
      attr_writer :mapper

      EVENT_NAME = 'request.google_api.search'

      def initialize
        self.connection = Core::Registries::Connection[:google_api]
      end

      def perform(query)
        options = { key: ENV['GOOGLE_API_KEY'], cx: ENV['GOOGLE_API_CX'], q: query }
        response = connection.get('customsearch/v1', options)
        items = response.body.fetch('items', [])
        items.map { |item| mapper.map(item) }

      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
      end

      private

      attr_accessor :connection

      def mapper
        @mapper ||= GoogleItemMapper.new
      end
    end
  end
end
