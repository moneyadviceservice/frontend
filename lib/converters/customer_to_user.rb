module Converters
  class CustomerToUser
    attr_reader :customer

    def initialize(customer)
      @customer = customer
    end

    def call
      raise('customer is not persisted') if customer.id.blank?

      User.find_by(customer_id: customer.id) || User.new(customer_attributes)
    end

    private

    def customer_attributes
      customer.attributes.reject{|k,_| [:state, :topics, :status_code].include?(k)}
    end
  end
end
