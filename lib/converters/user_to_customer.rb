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
      user.attributes.merge(
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        post_code: user.post_code,
        contact_number: user.contact_number,
        age_range: user.age_range
      )
    end
  end
end
