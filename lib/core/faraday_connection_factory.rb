require 'faraday'
require 'faraday/request/request_id'

module Core
  class FaradayConnectionFactory
    def self.build(url, timeout: 5, open_timeout: 5)
      Faraday.new(url: url, request: { timeout: timeout, open_timeout: open_timeout }) do |faraday|
        faraday.request :json
        faraday.request :request_id
        faraday.request :retry

        faraday.response :raise_error
        faraday.response :json

        faraday.use :instrumentation
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
