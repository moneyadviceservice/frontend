module Core
  class Customer < Entity
    attr_accessor :first_name, :last_name, :email, :post_code, :age_range,
                  :gender, :state, :topics, :newsletter_subscription,
                  :date_of_birth, :status_code
  end
end
