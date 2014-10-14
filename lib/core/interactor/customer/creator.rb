module Core
  module Interactors
    module Customer
      class Creator
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def call
          customer = Registry::Repository[:customer].find(email: user.email)
          user.customer_id = customer ? customer.id : Registry::Repository[:customer].create(user)

          user
        rescue
          yield if block_given?
        end
      end
    end
  end
end
