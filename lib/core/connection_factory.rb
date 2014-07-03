require 'faraday/request/request_id'
require 'faraday/response/link_header'

module Core
  class ConnectionFactory
    def self.build(url, timeout: 5, open_timeout: 5)
      options    = { url: url, request: { timeout: timeout, open_timeout: open_timeout } }
      connection = Faraday.new(options) do |faraday|
        faraday.request :json
        faraday.request :request_id
        faraday.request :retry

        faraday.response :raise_error
        faraday.response :json
        faraday.response :link_header

        faraday.use :instrumentation
        faraday.adapter Faraday.default_adapter
      end

      Connection.new(connection)
    end
  end
end
