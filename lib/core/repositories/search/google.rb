require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'
require 'core/repositories/search/google_request_mapper'

module Core::Repositories
  module Search
    class Google < Core::Repository
      attr_writer :request_mapper

      EVENT_NAME = 'request.google_api.search'

      def initialize
        self.connection = Core::Registries::Connection[:google_api]
      end

      def perform(query)
        options = { key: ENV['GOOGLE_API_KEY'], cx: ENV['GOOGLE_API_CX'], q: query }
        request_mapper.map(connection.get('customsearch/v1', options))

      rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
        raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
      end

      private

      attr_accessor :connection

      def request_mapper
        @request_mapper ||= GoogleRequestMapper.new
      end
    end
  end
end
