require 'core/entities/newsletter/subscription'

module Core::Newsletter
  class Subscriber
    attr_accessor :email
    private :email=

    def initialize(email)
      self.email = email
    end

    def call
      success, message = Core::Registries::Repository[:newsletter].register(email)
      Subscription.new(success, message)
    end
  end
end
