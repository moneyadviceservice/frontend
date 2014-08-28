module Core
  module Interactors
    class UserUpdater
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def call
        Core::Registry::Repository[:user].update_from_crm(user)
      end
    end
  end
end
