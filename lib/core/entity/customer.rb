module Core
  class Customer < Entity
    attr_accessor :first_name, :last_name, :email, :post_code, :age_range,
                  :gender, :state, :topics, :newsletter_subscription,
                  :date_of_birth, :status_code

    def active?
      state == 0
    end

    def attributes
      {
        first_name: first_name,
        last_name: last_name,
        email: email,
        post_code: post_code,
        age_range: age_range,
        gender: gender,
        state: state,
        topics: topics,
        newsletter_subscription: newsletter_subscription,
        date_of_birth: date_of_birth,
        status_code: status_code
      }
    end
  end
end
