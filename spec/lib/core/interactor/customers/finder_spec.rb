require 'spec_helper'

module Core
  module Interactors
    module Customers
      RSpec.describe Finder do
        describe 'call' do
          context 'when customer exists' do
            it 'returns the customer'
          end

          context 'when customer does not exist' do
            subject{ described_class.new('unknown') }

            it 'returns nil' do
              expect(subject.call).to be_nil
            end

            it_has_behavior 'optional failure block'
          end
        end
      end
    end
  end
end
