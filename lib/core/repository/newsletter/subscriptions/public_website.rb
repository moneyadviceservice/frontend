module Core::Repository
  module Newsletter
    module Subscriptions
      class PublicWebsite < Core::Repository::Base
        def initialize
          self.connection = Core::Registry::Connection[:public_website]
        end

        def register(email)
          params = { newsletter_subscription: email }

          connection.post('/%{locale}/newsletter-subscriptions.json' % { locale: I18n.locale }, params)
          true

        rescue Core::Connection::UnprocessableEntity
          false

        rescue Core::Connection::ConnectionFailed, Core::Connection::ClientError
          raise RequestError, 'Unable to create newsletter subscription on Public Website'
        end

        private

        attr_accessor :connection

      end
    end
  end
end
