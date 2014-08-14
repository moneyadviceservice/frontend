module Core
  module Interactors
    module Customers
      class Creator
        attr_reader :customer

        def initialize(customer)
          @customer = customer
        end

        def call
          Registry::Repository[:customers].create(customer)
        end
      end
    end
  end
end
