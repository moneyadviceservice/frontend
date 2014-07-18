module Core::Repository
  module NewsletterSubscriptions
    class PublicWebsite < Core::Repository::Base
      def initialize
        self.connection = Core::Registry::Connection[:public_website]
      end

      def register(email)
        params = { newsletter_subscription: email }

        connection.post('/%{locale}/newsletter-subscriptions.json' % { locale: I18n.locale }, params)
        true

      rescue Core::Connection::Http::UnprocessableEntity
        false

      rescue Core::Connection::Http::ConnectionFailed, Core::Connection::Http::ClientError
        raise RequestError, 'Unable to create newsletter subscription on Public Website'
      end

      private

      attr_accessor :connection

    end
  end
end
