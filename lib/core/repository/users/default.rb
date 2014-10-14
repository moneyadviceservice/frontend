module Core
  module Repository
    module Users
      class Default
        def update_from_crm(user)
          fail 'customer_id is blank' if customer_id(user).blank?
          fail 'customer not in CRM' if customer(user).nil?

          updated_user = ::Converters::CustomerToUser.new(customer(user)).call
          success = updated_user.save # do not raise errors. otherwise user cannot login
          Rails.logger.warn("Tried to update user with id #{updated_user.id} from CRM but did not save") unless success

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
