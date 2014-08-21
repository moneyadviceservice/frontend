module Core
  module Repository
    module Customers
      class Cream
        def create(user)
          response = ::Cream::Client.instance.create_customer(user)
          response["d"]["ContactId"]
        end
      end
    end
  end
end
