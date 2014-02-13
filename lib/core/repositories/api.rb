require 'faraday'
require 'faraday/request/request_id'
require 'forwardable'

module Core
  module Repositories
    class API
      extend Forwardable

      RequestError = Module.new

      def_delegator :connection, :options

      def initialize(url, type, timeout: 5, open_timeout: 5)
        options = { url: url, request: { timeout: timeout, open_timeout: open_timeout } }

        self.type       = type
        self.connection = Faraday.new(options) do |faraday|
          faraday.request :json
          faraday.request :request_id

          faraday.response :raise_error
          faraday.response :json

          faraday.use :instrumentation
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
