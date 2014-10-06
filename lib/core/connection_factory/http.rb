require 'faraday/request/request_id'
require 'faraday/response/link_header'

module Core
  module ConnectionFactory
    class Http
      def self.build(url, timeout: 5, open_timeout: 5, retries: 2)
        options    = { url: url, request: { timeout: timeout, open_timeout: open_timeout, retries: retries } }
        connection = Faraday.new(options) do |faraday|
          faraday.request :json
          faraday.request :request_id
          faraday.request :retry, retries

          faraday.response :raise_error
          faraday.response :json
          faraday.response :link_header

          faraday.use :instrumentation
          faraday.adapter Faraday.default_adapter
        end

        Core::Connection::Http.new(connection)
      end
    end
  end
end
