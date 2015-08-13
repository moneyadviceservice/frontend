module Core
  class NewsletterSubscriptionCreator
    attr_accessor :email
    private :email=

    def initialize(email)
      self.email = email
    end

    def call
      result = Core::Registry::Repository[:newsletter_subscription].register(email)

      if result
        result
      elsif block_given?
        yield
      else
        false
      end
    end
  end
end
