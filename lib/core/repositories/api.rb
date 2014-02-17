require 'core/faraday_connection_factory'
require 'forwardable'

module Core
  module Repositories
    class API
      extend Forwardable

      class RequestError < StandardError
        attr_reader :original

        def initialize(msg, original=$!)
          super(msg)
          @original = original
        end
      end

      def initialize(url, type, options = {})
        self.type       = type
        self.connection = FaradayConnectionFactory.build(url)
      end

      def find(id)
        response = connection.get('/%{locale}/%{type}/%{id}.json' %
                                    { locale: I18n.locale, type: type.pluralize, id: id })
        response.body
      rescue Faraday::Error::ResourceNotFound
        nil
      rescue Faraday::Error::ConnectionFailed, Faraday::Error::ClientError => e
        raise RequestError, "Unable to fetch #{type} data from API Service"
      end

      private

      attr_accessor :connection, :type

    end
  end
end
