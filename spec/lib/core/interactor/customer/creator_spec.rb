require 'lib/core/interactor/shared_examples/optional_failure_block'

module Core
  module Interactors
    module Customer
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
          let(:user) { User.create!(attributes) }
          subject { described_class.new(user) }

          context 'when customer already exists' do
            before :each do
              user
              user.update_column(:customer_id, nil)
            end

            it 'does not throw an exception' do
              expect do
                subject.call { fail 'hello' }
              end.not_to raise_error
            end

            it 'does not create another CRM customer' do
              expect { subject.call }.to_not change { Registry::Repository[:customer].customers.size }
            end

            it 'associates user and customer' do
              customer = subject.call
              expect(customer.customer_id).to eql(Registry::Repository[:customer].customers.last[:id])
            end
          end

          context 'when customer does not exist' do
            let(:saved_customer) { Core::Registry::Repository[:customer].find(id: user.customer_id) }

            it 'creates them' do
              expect { subject.call }.to change { Core::Registry::Repository[:customer].customers.size }.by(1)
            end

            it 'sets the correct attributes' do
              subject.call
              expect(saved_customer.first_name).to include(user.first_name)
            end

            it 'calls back to set user.customer_id' do
              subject.call
              expect(user.customer_id).to eql(saved_customer.id)
            end

            it 'persists user.customer_id' do
              subject.call
              expect(user.changed?).to be_falsey
            end
          end
        end
      end
    end
  end
end
