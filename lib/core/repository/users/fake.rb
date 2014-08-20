module Core
  module Repository
    module Users
      class Fake
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def call
          raise 'customer_id is blank' if customer_id.blank?
          raise 'customer not in CRM' if customer.nil?

          updated_user = ::Converters::CustomerToUser.new(customer).call
          updated_user.save!
          updated_user
        end

        private

        def customer_id
          user.customer_id
        end

        def customer
          Core::Interactors::Customers::Finder.new(customer_id).call
        end
      end
    end
  end
end
