module Converters
  class CustomerToUser
    attr_reader :customer

    def initialize(customer)
      @customer = customer
      @reject_email = true
    end

    def call
      raise('customer is not persisted') if customer.id.blank?

      existing_user = User.find_by(customer_id: customer.id)

      if existing_user
        existing_user.attributes = existing_customer_attributes
        existing_user
      else
        User.new(new_customer_attributes)
      end
    end

    private

    # We don't want to the crm to update the our user email by default
    # otherwise if crm changes email users cannot login
    # override with caution
    def reject_email
      @reject_email
    end

    def existing_customer_attributes
      hash = customer.attributes.reject{|k,_| [:state, :topics, :status_code].include?(k)}.compact
      hash.delete(:email) if reject_email
      hash
    end

    def new_customer_attributes
      attributes = existing_customer_attributes
      attributes[:customer_id] = customer.id
      attributes
    end
  end
end
