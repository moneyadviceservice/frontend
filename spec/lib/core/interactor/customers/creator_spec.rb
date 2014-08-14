require 'spec_helper'
require 'lib/core/interactor/shared_examples/optional_failure_block'

module Core
  module Interactors
    module Customers
      RSpec.describe Creator do
        around :each do |example|
          old = (Core::Registry::Repository[:customers] rescue nil)
          Core::Registry::Repository[:customers] = Core::Repository::Customers::Fake.new
          Core::Registry::Repository[:customers].clear

          example.run

          Core::Registry::Repository[:customers] = old
        end

        describe '#call' do
          context 'when customer already exists' do
            let(:customer){ Customer.new('phil', first_name: 'Phil') }
            subject{ described_class.new(customer) }

            before :each do
              subject.call
            end

            it 'throws an exception' do
              expect do
                subject.call{ raise 'hello' }
              end.to raise_error('hello')
            end

            it_has_behavior 'optional failure block'
          end

          context 'when customer does not exists' do
            let(:customer){ Customer.new('phil', first_name: 'Phil') }
            subject{ described_class.new(customer) }

            it 'creates them' do
              subject.call
              expect(Core::Registry::Repository[:customers].customers).to include(customer)
            end

            it 'sets the correct attributes' do
              subject.call
              saved_customer = Core::Registry::Repository[:customers].find(customer.id)
              expect(saved_customer.first_name).to include(customer.first_name)
            end
          end
        end
      end
    end
  end
end
