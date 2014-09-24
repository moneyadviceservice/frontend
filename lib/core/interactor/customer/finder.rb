module Core
  module Interactors
    module Customer
      class Finder
        attr_reader :id

        def initialize(id)
          @id = id
        end

        def call
          customer = Registry::Repository[:customer].find(id: id)

          if customer
            customer
          elsif block_given?
            yield
          end
        end
      end
    end
  end
end
