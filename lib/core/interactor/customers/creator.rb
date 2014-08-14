module Core
  module Interactors
    module Customers
      class Creator
        attr_reader :customer

        def initialize(customer)
          @customer = customer
        end

        def call(&block)
          Registry::Repository[:customers].create(customer)
        rescue
          block.call if block_given?
        end
      end
    end
  end
end
