module Core
  module Interactors
    module Customers
      class Updater
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def call
          Registry::Repository[:customers].update(customer)
        end

        private

        def customer
          user.to_customer
        end
      end
    end
  end
end
