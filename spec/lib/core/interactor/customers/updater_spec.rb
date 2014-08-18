require 'spec_helper'

module Core
  module Interactors
    module Customers
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
          let(:user){ User.create!(attributes) }
          subject{ described_class.new(user) }

          context 'when customer exists' do
            it 'updates attributes' do
              user
              user.first_name = 'Philip'

              subject = described_class.new(user)
              subject.call

              customer = Core::Registry::Repository[:customers].customers.first
              expect(customer.first_name).to eql('Philip')
            end
          end

          context 'when customer does not exist' do
            let(:user){ User.new(customer_id: 'customer_123') }
            it 'raises an exception' do
              expect{ subject.call }.to raise_error
            end
          end
        end
      end
    end
  end
end
