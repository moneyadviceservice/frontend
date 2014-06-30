require 'core/entities/newsletter/subscription'

module Core::Newsletter
  class Subscriber
    attr_accessor :email
    private :email=

    def initialize(email)
      self.email = email
    end

    def call(&block)
      status, message = Core::Registries::Repository[:newsletter_subscriptions].register(email)
      subscription = Subscription.new(status, message)

      if subscription.valid?
        subscription
      else
        block.call(subscription) if block_given?
      end
    end
  end
end
