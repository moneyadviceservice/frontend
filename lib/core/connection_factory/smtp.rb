require 'mail'

module Core
  module ConnectionFactory
    class Smtp
      def self.build(options)
        smtp_server = PseudoSmtpServer.new(options)

        Core::Connection::Smtp.new(smtp_server)
      end
    end

    class PseudoSmtpServer
      attr_accessor :from_address, :mail, :config
      private :from_address=, :mail, :config

      def initialize(defaults = {})
        self.from_address = defaults.fetch(:from_address)
        self.mail = defaults.fetch(:mail, Mail.new)
        self.config = defaults.fetch(:config, Rails.configuration)
      end

      def deliver(message_details)
        mail.delivery_method(config.feedback_delivery_method)
        mail.raise_delivery_errors = config.raise_feedback_delivery_errors

        mail.from    = from_address
        mail.to      = message_details[:recipient]
        mail.subject = message_details[:subject]
        mail.body    = message_details[:body]

        mail.deliver
      end
    end
  end
end
