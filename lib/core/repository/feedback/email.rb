module Core::Repository
  module Feedback
    class Email < Core::Repository::Base
      attr_accessor :connection
      private :connection

      def initialize
        self.connection = Core::Registry::Connection[:internal_email]
      end

      def create(entity)
        email_details = {
          recipient: entity.recipient,
          subject:   entity.subject,
          body:      entity.body
        }
        connection.deliver(email_details)
      end
    end
  end
end
