module Converters
  class UserToCustomer
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      Core::Customer.new(customer_id, user_hash)
    end

    private

    def customer_id
      user.customer_id
    end

    def user_hash
      user.attributes
    end
  end
end
