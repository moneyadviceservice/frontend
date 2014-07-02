module Core::Repository
  class Base
    class RequestError < StandardError
      attr_reader :original

      def initialize(msg, original=$!)
        super(msg)
        @original = original
      end
    end
  end
end
