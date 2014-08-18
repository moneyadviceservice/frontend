module Converters
  class CustomerToUser
    attr_reader :customer

    def initialize(customer)
      @customer = customer
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

    def existing_customer_attributes
      customer.attributes.reject{|k,_| [:state, :topics, :status_code].include?(k)}.compact
    end

    def new_customer_attributes
      attributes = existing_customer_attributes
      attributes[:customer_id] = customer.id
      attributes
    end
  end
end
