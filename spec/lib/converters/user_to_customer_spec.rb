require 'spec_helper'

module Converters
  RSpec.describe UserToCustomer do
    let(:user){ User.new(attributes) }
    let(:attributes) do
      {
        first_name: 'Phil',
        customer_id: 'customer_123'
      }
    end
    subject{ described_class.new(user) }

    describe '#call' do
      it 'returns a customer' do
        expect(subject.call).to be_a(Core::Customer)
      end

      it 'returns correct id' do
        customer = subject.call
        expect(customer.id).to eql(attributes[:customer_id])
      end

      it 'returns with correct attributes' do
        customer = subject.call
        expect(customer.first_name).to eql(attributes[:first_name])
      end
    end
  end
end
