module Core::Newsletter
  class Subscriber
    attr_accessor :email
    private :email=

    def initialize(email)
      self.email = email
    end

    def call(&block)
      result = Core::Registry::Repository[:newsletter_subscription].register(email)

      if result
        result
      elsif block_given?
        block.call
      else
        false
      end
    end
  end
end
