require 'core/faraday_connection_factory'
require 'core/repositories/repository'

module Core::Repositories
  module Articles
    class PublicWebsite < Core::Repository
      def initialize(url)
        self.connection = Core::FaradayConnectionFactory.build(url)
      end

      def find(id)
        response = connection.get('/%{locale}/articles/%{id}.json' %
                                    { locale: I18n.locale, id: id })
        response.body
      rescue Faraday::Error::ResourceNotFound
        nil
      rescue Faraday::Error::ConnectionFailed, Faraday::Error::ClientError => e
        raise RequestError, 'Unable to fetch Article JSON from Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
