module Core::Repository
  module NewsletterSubscriptions
    class Cream < Core::Repository::Base
      def register(email)
        ::Cream::ClientV2.new.subscribe_to_newsletter(email)
      end
    end
  end
end
