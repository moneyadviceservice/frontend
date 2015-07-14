module Core::Repository
  module NewsletterSubscriptions
    class Fake < Core::Repository::Base
      def register(email)
        return false if email == 'clark.kent@dailyplanet'

        true
      end
    end
  end
end
