module Core
  module Repository
    module Users
      class Fake
        def update_from_crm(user)
          raise 'customer_id is blank' if customer_id(user).blank?
          raise 'customer not in CRM' if customer(user).nil?

          updated_user = ::Converters::CustomerToUser.new(customer(user)).call
          updated_user.save!
          updated_user
        end

        private

        def customer_id(user)
          user.customer_id
        end

        def customer(user)
          Core::Interactors::Customer::Finder.new(customer_id(user)).call
        end
      end
    end
  end
end
