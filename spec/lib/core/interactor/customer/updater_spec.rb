module Core
  module Interactors
    module Customer
      RSpec.describe Updater do
        describe '#call' do
          let(:attributes) do
            {
              first_name: 'Phil',
              email: 'phil@example.com',
              password: 'password',
              post_code: 'NE1 6EE'
            }
          end
          let!(:user) { User.create!(attributes) }
          subject { described_class.new(user) }

          context 'when customer exists' do
            before :each do
              Interactors::Customer::Creator.new(user).call
            end

            let(:first_name) { 'Philip' }

            it 'updates attributes' do
              user.first_name = first_name

              subject = described_class.new(user)
              subject.call

              customer = Core::Registry::Repository[:customer].find(id: user.customer_id)
              expect(customer.first_name).to eql(first_name)
            end
          end

          context 'when customer does not exist' do
            let(:user) { User.new(customer_id: 'customer_123') }
            it 'raises an exception' do
              expect { subject.call }.to raise_error
            end
          end
        end
      end
    end
  end
end
