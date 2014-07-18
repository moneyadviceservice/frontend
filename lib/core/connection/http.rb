require 'faraday'

module Core
  module Connection
    class Http < SimpleDelegator
      Error = Class.new(StandardError) do
        attr_reader :original

        def initialize(original=$!)
          super
          @original = original
        end
      end

      ClientError         = Class.new(Error)
      ConnectionFailed    = Class.new(Error)
      ResourceNotFound    = Class.new(Error)
      UnprocessableEntity = Class.new(Error)

      def get(*args)
        __getobj__.get(*args)

      rescue Faraday::Error::ResourceNotFound
        raise ResourceNotFound

      rescue Faraday::Error::ConnectionFailed
        raise ConnectionFailed

      rescue Faraday::Error::ClientError
        raise ClientError

      end

      def post(*args)
        __getobj__.post(*args)

      rescue Faraday::Error::ConnectionFailed
        raise ConnectionFailed

      rescue Faraday::Error::ClientError => error
        case error.response[:status]
          when 422
            raise UnprocessableEntity
          else
            raise ClientError
        end

      end

    end
  end
end
