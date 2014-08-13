module Core
  module Interactors
    module Customers
      class Finder
        def initialize(id)
        end

        def call(&block)
          block.call if block_given?
        end
      end
    end
  end
end
