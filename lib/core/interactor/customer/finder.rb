module Core
  module Interactors
    module Customer
      class Finder
        attr_reader :id

        def initialize(id)
          @id = id
        end

        def call(&block)
          customer = Registry::Repository[:customer].find(id)

          if customer
            customer
          else
            block.call if block_given?
          end
        end
      end
    end
  end
end
