require 'core/connection'
require 'core/registries/connection'
require 'core/repositories/repository'

module Core::Repositories
  module Search
    class Google < Core::Repository
      EVENT_NAME = 'request.google_api.search'
      SECOND_TO_LAST = -2

      def initialize
        self.connection = Core::Registries::Connection[:google_api]
      end

      def perform(query)
        options = { key: ENV['GOOGLE_API_KEY'], cx: ENV['GOOGLE_API_CX'], q: query }

        response = connection.get('customsearch/v1', options)
        response.body['items'].map do |result_data|
          {
            id:          result_data['link'].split('/').last,
            type:        result_data['link'].split('/')[SECOND_TO_LAST],
            description: extract_description(result_data['pagemap']['metatags']),
            title:       result_data['title']
          }
        end
      end

      private

      attr_accessor :connection

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
