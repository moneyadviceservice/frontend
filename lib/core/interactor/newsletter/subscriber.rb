module Core::Newsletter
  class Subscriber
    attr_accessor :email
    private :email=

    def initialize(email)
      self.email = email
    end

    def call(&block)

      # if status == 'OK'
      #   true
      # else
      #   block.call if block_given?
      # else
      #   false
      # end

      status, message = Core::Registry::Repository[:newsletter_subscription].register(email)
      subscription = Subscription.new(status, message)

      if subscription.success?
        subscription
      else
        block.call(subscription) if block_given?
      end
    end
  end
end
