module Core
  module Repository
    module Customers
      class Fake
        @@customers = []
        cattr_reader :customers

        def find(id)
          customers.detect{|c| c.id == id}
        end

        # return customer id
        def create(customer)
          raise('Already exists') if customers.detect{|c| c.id == customer.id}

          customer = customer.dup
          customer.send :id=, "customer_#{rand(1000000)}"
          customers << customer

          customer.id
        end

        def update(customer)
          c = find(customer.id)

          raise 'does not exist' unless c

          c.first_name = customer.first_name
        end

        def clear
          customers.clear
        end

        def valid_for_authentication?(id)
          find(id)
        end
      end
    end
  end
end
