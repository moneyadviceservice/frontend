require 'spec_helper'

module Converters
  RSpec.describe CustomerToUser do
    context 'when user exists' do
      let(:customer){ Core::Customer.new(user.customer_id, {}) }
      let!(:user) do
        Rails.configuration.active_record.record_timestamps = true
        user = User.new(first_name: 'Phil',
                        email: 'phil@example.com',
                        password: 'password',
                        post_code: 'NE1 6EE')
                        user.save
                        user
      end
      subject{ described_class.new(customer) }

      it 'finds the user' do
        expect(subject.call).to eql(user)
      end

      it 'updates new attributes'
    end

    context 'when user does not exist' do
      let(:customer){ Core::Customer.new('customer_phil', first_name: 'Phil') }
      subject{ described_class.new(customer) }

      it 'builds a user object' do
        user = subject.call

        expect(user).to be_a(User)
        expect(user.first_name).to eql('Phil')
      end
    end

    context 'when customer is not persisted' do
      let(:customer){ Core::Customer.new(nil, first_name: 'Phil') }
      subject{ described_class.new(customer) }

      it 'raise en exception' do
        expect{ subject.call }.to raise_error
      end
    end
  end
end
