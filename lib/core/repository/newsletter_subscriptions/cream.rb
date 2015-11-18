module Core::Repository
  module NewsletterSubscriptions
    class Cream < Core::Repository::Base
      def register(email)
        if ::Cream::ClientV2.new.subscribe_to_newsletter(email)
          true
        else
          raise 'Cream count not subscribe to newsletter'
        end
      end
    end
  end
end
