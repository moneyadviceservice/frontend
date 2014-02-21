require 'core/registries/connection'
require 'core/repositories/repository'
require 'faraday'

module Core::Repositories
  module ActionPlans
    class PublicWebsite < Core::Repository
      def initialize
        self.connection = Core::Registries::Connection[:public_website]
      end

      def find(id)
        response = connection.get('/%{locale}/action_plans/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        response.body
      rescue Faraday::Error::ResourceNotFound
        nil
      rescue Faraday::Error::ConnectionFailed, Faraday::Error::ClientError => e
        raise RequestError, 'Unable to fetch Action Plan JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
