module Core
  module Repository
    module Customers
      class Fake
        def find(id)
          if id == 'known'
            Customer.new(id)
          end
        end
      end
    end
  end
end
