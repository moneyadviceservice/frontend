require 'faraday'
require 'forwardable'

module Core
  module Repositories
    class API
      extend Forwardable

      RequestError = Module.new

      def initialize(url, type)
        self.type       = type
        self.connection = Faraday.new(url: url) do |faraday|

          faraday.request :json
          faraday.response :raise_error
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      def find(id)
        response = connection.get("/%{locale}/%{type}/%{id}.json" %
                                    { locale: I18n.locale, type: type.pluralize, id: id })
        response.body
      rescue Faraday::Error::ResourceNotFound
        nil
      rescue Faraday::Error::ConnectionFailed, Faraday::Error::ClientError => e
        raise e.extend(RequestError)
      end

      private

      attr_accessor :connection, :type

    end
  end
end
