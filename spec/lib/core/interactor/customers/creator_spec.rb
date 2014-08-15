require 'spec_helper'
require 'lib/core/interactor/shared_examples/optional_failure_block'

module Core
  module Interactors
    module Customers
      RSpec.describe Creator do
        describe '#call' do
          let(:attributes) do
            {
              first_name: 'Phil',
              email: 'phil@example.com',
              password: 'password',
              post_code: 'NE1 6EE'
            }
          end
          let(:user){ User.create!(attributes) }
          subject{ described_class.new(user) }

          context 'when customer already exists' do
            before :each do
              user
              subject.call
            end

            it 'throws an exception' do
              expect do
                subject.call{ raise 'hello' }
              end.to raise_error('hello')
            end

            it_has_behavior 'optional failure block'
          end

          context 'when customer does not exist' do
            it 'creates them' do
              expect{ subject.call }.to change{ Core::Registry::Repository[:customers].customers.size }.by(1)
            end

            it 'sets the correct attributes' do
              subject.call
              saved_customer = Core::Registry::Repository[:customers].find(user.customer_id)
              expect(saved_customer.first_name).to include(user.first_name)
            end

            it 'calls back to set user.customer_id' do
              subject.call
              saved_customer = Core::Registry::Repository[:customers].find(user.customer_id)
              expect(user.customer_id).to eql(saved_customer.id)
            end

            it 'persists user.customer_id' do
              subject.call
              saved_customer = Core::Registry::Repository[:customers].find(user.customer_id)
              expect(user.changed?).to be_falsey
            end
          end
        end
      end
    end
  end
end
