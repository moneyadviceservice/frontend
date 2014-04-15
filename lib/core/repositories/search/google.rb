require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Search
    class Google < Core::Repository
      EVENT_NAME = 'request.google_api.search'

      def initialize
        self.connection = Core::Registries::Connection[:google_api]
      end

      def perform(query)
        options = { key: ENV['GOOGLE_API_KEY'], cx: ENV['GOOGLE_API_CX'], q: query }

        response = connection.get('customsearch/v1', options)
        response.body['items']
      end

      private

      attr_accessor :connection
    end
  end
end
