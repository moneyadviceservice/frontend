module Core
  module Repository
    module Customers
      class Fake
        @@customers = []
        cattr_reader :customers

        def find(options = {})
          id = options[:id]
          email = options[:email]

          response = customers.find { |c| c[:id] == id || c[:email] == email }
          Core::Customer.new(response[:id], response) if response
        end

        # return customer id
        def create(user)
          fail('Already exists') if customers.find { |c| c[:id] == user.customer_id }

          customer = user.to_customer
          hash = customer.attributes
          hash[:id] = "customer_#{rand(1_000_000)}"
          customers << hash

          hash[:id]
        end

        def update(customer)
          c = customers.find { |c| c[:id] == customer.id }

          fail 'does not exist' unless c

          c[:first_name] = customer.first_name
          c[:email] = customer.email
          c[:post_code] = customer.post_code
          c[:newsletter_subscription] = customer.newsletter_subscription
        end

        def clear
          customers.clear
        end

        def valid_for_authentication?(id)
          true
        end
      end
    end
  end
end
