module Core
  module Interactors
    class UserUpdater
      attr_reader :user
      delegate :customer_id, to: :user

      def initialize(user)
        @user = user
      end

      def call
        Core::Registry::Repository[:user].update_from_crm(user) if customer_id.present?
      end
    end
  end
end
