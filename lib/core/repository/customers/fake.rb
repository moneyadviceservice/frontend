module Core
  module Repository
    module Customers
      class Fake
        @@customers = []
        cattr_reader :customers

        def find(id)
          customers.detect{|c| c.id == id}
        end

        def create(customer)
          raise('Already exists') if customers.detect{|c| c.id == customer.id}

          customers << customer
        end

        def update(customer)
          c = find(customer.id)

          raise 'does not exist' unless c

          c.first_name = customer.first_name
        end

        def clear
          customers.clear
        end
      end
    end
  end
end
