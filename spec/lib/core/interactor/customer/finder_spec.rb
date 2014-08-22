require 'spec_helper'
require 'lib/core/interactor/shared_examples/optional_failure_block'

module Core
  module Interactors
    module Customer
      RSpec.describe Finder do
        describe 'call' do
          context 'when customer exists' do
            subject{ described_class.new('known') }

            let(:data) do
              {
                first_name: 'Phil',
                email: 'phil@example.com'
              }
            end

            before do
              allow(Registry::Repository).to receive(:[]).with(:customer) do
                double(find: ::Core::Customer.new('known', data))
              end
            end

            it 'returns a customer' do
              expect(subject.call).to be_a(::Core::Customer)
            end

            it 'returns the correct customer' do
              customer = subject.call

              expect(customer.id).to eql('known')
              expect(customer.first_name).to eql(data[:first_name])
              expect(customer.email).to eql(data[:email])
            end
          end

          context 'when customer does not exist' do
            subject{ described_class.new('unknown') }

            before do
              allow(Registry::Repository).to receive(:[]).with(:customer) do
                double(find: nil)
              end
            end

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
