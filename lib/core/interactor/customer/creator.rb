module Core
  module Interactors
    module Customer
      class Creator
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def call(&block)
          customer = Registry::Repository[:customer].find(email: user.email)

          if customer
            user.customer_id = customer.id
            user
          else
            customer_id = Registry::Repository[:customer].create(user)
            user.customer_id = customer_id
            user
          end
        rescue
          block.call if block_given?
        end
      end
    end
  end
end
